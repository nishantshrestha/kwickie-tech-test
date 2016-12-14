//
//  Router.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 15/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // Create the Singleton instance
    static let sharedInstance = NetworkManager()
    
    public var baseURL = "https://bigdev.kwickie.com/api"
    
    public var accessToken = ""
    
    // Private initialiser
    private init() {} //This prevents others from using the default '()' initializer for this class.
}

enum AuthRouter {
    case Login
}

extension AuthRouter: CustomStringConvertible {
    var description: String {
        var url: String?
        
        switch self {
            case .Login: url = "/members/login"
        }
        
        return NetworkManager.sharedInstance.baseURL + url!
    }
}

enum KwickiesRouter {
    case Approved
}

extension KwickiesRouter: CustomStringConvertible {
    
    static let kwickiesURL = NetworkManager.sharedInstance.baseURL + "/kwickies"
    
    var description: String {
        var url: String?
        
        switch self {
            case .Approved: url = "/approved"
        }
        
        return KwickiesRouter.kwickiesURL + url! + "?access_token=" + NetworkManager.sharedInstance.accessToken
    }
}
