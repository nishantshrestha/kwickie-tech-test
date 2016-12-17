//
//  SignInController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
import JGProgressHUD

class SignInController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up textfield delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Set up default values
        emailTextField.text = "kevin.jonas@kwickie.com"
        passwordTextField.text = "KwickieRocks"
    }

    @IBAction func signInButtonPressed(_ sender: AnyObject) {
        authenticateUser()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func authenticateUser() {
        // Create the parameters based on the user input
        let params: Parameters = [
            "email": emailTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]
        
        // Show progressHUD
        let progressHUD = JGProgressHUD()
        progressHUD.textLabel.text = "Logging in..."
        progressHUD.show(in: view)
        
        signInWithParameters(params: params) { [weak self] (user, error) in
            // Dismiss progressHUD
            progressHUD.dismiss()
            
            // If a user object was returned, then proceed.
            if let user = user {
                // Go to KwickiesController
                if let kwickiesCtrl = KwickiesController.storyboardInstance() {
                    // Pass the user object
                    kwickiesCtrl.user = user
                    
                    // TODO: Should we fetch the videos here?
                    
                    // Push controller to the navigation stack
                    self?.navigationController?.pushViewController(kwickiesCtrl, animated: true)
                }
                
            } else {
                // Else show an error message
                print("Something went wrong while trying to login. Server message: \(error)")
            }
        }
    }
    
    func signInWithParameters(params: Parameters, completionHandler: @escaping (User?, String) -> Void) {
        
        // TODO: Create separate network request manager that handles errors?
        
        // Perform network request
        Alamofire.request(AuthRouter.Login.description, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { [weak self] response in
                switch response.result {
                case .failure(let error):
                    print("Login error. \(error.localizedDescription)")
                    
                    // Call completion handler with nil user object
                    completionHandler(nil, error.localizedDescription)
                case .success:
                    if let data = response.data {
                        // Create JSON from response data
                        let json = JSON(data: data)
                        
                        // Ensure that there were no errors during login.
                        if let errorDictionary = json["error"].dictionary {
                            // Get the error message if available, else use generic error message
                            let message = errorDictionary["message"]?.string ?? "Login failed. Please try again."
                            
                            // Call completion handler
                            completionHandler(nil, message)
                        } else {
                            if let accessToken = json["id"].string, let userDictionary = json["user"].dictionaryObject {
                                let user = Mapper<User>().map(JSON: userDictionary)
                                
                                // Set the accessToken in the singleton class.
                                NetworkManager.sharedInstance.accessToken = accessToken
                                
                                // TODO: Also store the accessToken in the NSUserDefaults so the user doesn't have to login everytime.
                                
                                // Call completion handler
                                completionHandler(user, "")
                            }
                        }
                    }
                }
            }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            // Focus on the password field
            passwordTextField.becomeFirstResponder()
        } else {
            // Resign first responder
            textField.resignFirstResponder()
            
            // Call the authentication function
            authenticateUser()
        }
        return true
    }
}
