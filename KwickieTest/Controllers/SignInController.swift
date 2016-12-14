//
//  SignInController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import Alamofire
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
        
        signInWithParameters(params: params) { (status, authToken) in
            // If the status was success, then proceed.
            if status {
                
            } else { // Else show an error message
                
            }
        }
    }
    
    func signInWithParameters(params: Parameters, completionHandler: (Bool, String) -> Void) {
        
        let loginURL = "https://bigdev.kwickie.com/api/members/login"
        
        // Perform network request
        Alamofire.request(loginURL, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { [weak self] response in
                if let data = response.data {
                    let json = JSON(data: data)
                    
                    print(json)
                }
        }
    }
}
