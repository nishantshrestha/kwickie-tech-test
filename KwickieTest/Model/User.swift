//
//  Member.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import ObjectMapper

class User: Mappable {
    
    var userID: Int!
    var email: String!
    var profilePicturePath: String!
    var firstName: String!
    var lastName: String!
    
    // TODO: Implement other properties (not crucial for tech test)
    
    required init?(map: Map) {
       // Validate JSON response here
    }
    
    func mapping(map: Map) {
        userID <- map["id"]
        email <- map["email"]
        profilePicturePath <- map["profilePicturePath"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
    }
    
    func fullName() -> String {
        return firstName.appending(" ").appending(lastName)
    }
}
