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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButtonPressed(_ sender: AnyObject) {
        
        // Create the parameters based on the user input
        let params: Parameters = [
            "email": "kevin.jonas@kwickie.com",
            "password": "KwickieRocks"
        ]
        
        signInWithParameters(params: params) { [weak self] (user, error) in
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
                                
                                // Call completion handler
                                completionHandler(user, "")
                            }
                        }
                    }
                }
            }
    }
}
