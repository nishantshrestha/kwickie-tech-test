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
    
    func kwickieUsersAttributedString() -> NSAttributedString {
        // Create bold attributed string for question user
        let questionUserAttributedString = NSAttributedString(string: questionUser.fullName(), attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        // Create the attribute string for the description
        let descriptionText = " had a kwickie with "
        let descriptionAttributedString = NSAttributedString(string: descriptionText, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
        
        // Create bold attributed string for answer user
        let answerUserAttributedString = NSAttributedString(string: answerUser.fullName(), attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        // Combine all of them
        let usersAttributedString = NSMutableAttributedString(attributedString: questionUserAttributedString)
        usersAttributedString.append(descriptionAttributedString)
        usersAttributedString.append(answerUserAttributedString)
        
        return usersAttributedString
    }
}
