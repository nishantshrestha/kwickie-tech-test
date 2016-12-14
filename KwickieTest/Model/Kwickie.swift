//
//  Kwickie.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import ObjectMapper

class Kwickie: Mappable {
    
    var kwickieID: Int!
    var questionUser: User!
    var answerUser: User!
    
    // TODO: Implement other properties (not crucial for tech test)
    
    required init?(map: Map) {
        // Validate JSON response here
    }
    
    func mapping(map: Map) {
        kwickieID <- map["id"]
        questionUser <- map["questionUser"]
        answerUser <- map["answerUser"]
    }
}
