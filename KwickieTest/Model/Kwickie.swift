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
    var kwickieVideo: Video!
    var commentsCount: Int!
    var liked: Bool!
    var likeCount: Int!
    
    // TODO: Implement other properties (not crucial for tech test)
    
    required init?(map: Map) {
        // Validate JSON here
    }
    
    func mapping(map: Map) {
        print(map.JSON)
        
        kwickieID <- map["id"]
        questionUser <- map["questionUser"]
        answerUser <- map["answerUser"]
        kwickieVideo <- map["kwickieVideo"]
        commentsCount <- map["kwickieCommentProperties.commentsCount"]
        liked <- map["liked"]
        likeCount <- map["likesCount"]
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
    
    func likeCountString() -> String {
        if likeCount == 1 {
            return "1 Like"
        } else {
            return "\(likeCount ?? 0) Likes"
        }
    }
    
    func commentCountString() -> String {
        if commentsCount == 1 {
            return "1 Comment"
        } else {
            return "\(commentsCount ?? 0) Comments"
        }
    }
}

class Video: Mappable {
    
    var id: Int!
    var duration: Int!
    var createdAt: String!
    var highQualityURL: String!
    var lowQualityURL: String!
    var posterURL: String!
    var processPlaylistURL: String!
    var thumbTransparentUrl: String!
    
    required init?(map: Map) {
        // Validate JSON
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        duration <- map["duration"]
        createdAt <- map["createdAt"]
        highQualityURL <- map["highQualityURL"]
        lowQualityURL <- map["lowQualityURL"]
        posterURL <- map["posterURL"]
        processPlaylistURL <- map["processPlaylistURL"]
        thumbTransparentUrl <- map["thumbTransparentUrl"]
    }
    
}
