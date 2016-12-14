//
//  SignInController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
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
        
        signInWithParameters(params: params) { (user, error) in
            // If a user object was returned, then proceed.
            if let user = user {
                // Debug prints
                print("auth token is: \(user.authToken)")
                print("welcome to kwickie: \(user.firstName)")
                
            } else {
                 // Else show an error message
                print("Login error. \(error)")
            }
        }
    }
    
    func signInWithParameters(params: Parameters, completionHandler: @escaping (User?, String) -> Void) {
        
        // TODO: Move this to a separate Router file.
        let loginURL = "https://bigdev.kwickie.com/api/members/login"
        
        // TODO: Create separate network request manager that handles errors?
        
        // Perform network request
        Alamofire.request(loginURL, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            // Debug JSON print
            .responseJSON { [weak self] response in
                if let data = response.data {
                    let json = JSON(data: data)
                    print(json)
                }
            }
            .responseObject { [weak self] (response: DataResponse<User>) in
                // Get the user response
                let user = response.result.value
                // Get errors, if any.
                let error = response.result.error?.localizedDescription ?? ""
                // Call completion handler
                completionHandler(user, error)
            }
    }
}
