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
    var createdAt: String?
    
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
        createdAt <- map["createdAt"]
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
        return (likeCount == 1) ? "1 like" : "\(likeCount ?? 0) likes"
    }
    
    func commentCountString() -> String {
        return (commentsCount == 1) ? "1 comment" : "\(commentsCount ?? 0) comments"
    }
    
    func timeSinceCreation() -> String {
        if let createdAt = createdAt {
            // Create date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            // Create the date object based on the string
            let createdDate = dateFormatter.date(from: createdAt)?.timeIntervalSince1970 ?? 0
            let currentDate = Date().timeIntervalSince1970
            
            let timeDifference = currentDate - createdDate // This stores the timedifference in seconds
            
            return getStringIntervalRepresentationFor(duration: timeDifference)
        }
        return ""
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
        processPlaylistURL <- map["processPlaylistUrl"]
        thumbTransparentUrl <- map["thumbTransparentUrl"]
    }
    
}
