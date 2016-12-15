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
        // Validate JSON here
    }
    
    func mapping(map: Map) {
        print(map.JSON)
        
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

class Video: Mappable {
    
    var id: Int!
    var duration: Int!
    var createdAt: String!
    var highQualityURL: String!
    var lowQualityURL: String!
    var posterURL: String!
    var processPlaylistURL: String!
    
    required init?(map: Map) {
        // Validate JSON
    }
    
    func mapping(map: Map) {
        /*
         "kwickieVideo": {
         accountId = 0;
         alertThumbHeight = 0;
         alertThumbUrl = "<null>";
         alertThumbWidth = 0;
         complete = 1;
         createdAt = "2016-10-27T18:12:35.000Z";
         description = "<null>";
         duration = 54586;
         highQualityUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d.mp4";
         id = 159100;
         lowQualityUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_low.mp4";
         minimalHighQualityUrl = "<null>";
         minimalLowQualityUrl = "<null>";
         minimalPlaylistUrl = "<null>";
         name = "<null>";
         playlistUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_part.m3u8";
         posterUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_share.png";
         processId = 159100;
         processPlaylistUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_part.m3u8";
         still = 0;
         stillSeconds = "8.973333333333333";
         systemVideo = 0;
         taggedForDeletionAt = "<null>";
         thumbHeight = 360;
         thumbTransparentUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_circle_transparent_thumb.png";
         thumbUrl = "http://d3sz3msbyl7jnh.cloudfront.net/bd1ad7159100c16cc2ec6456fb3127018fbea8ab0876c9efbf4f21ecbc57d0d_circle_thumb.jpg";
         thumbWidth = 640;
         },
        */
        
        id <- map["id"]
        duration <- map["duration"]
        createdAt <- map["createdAt"]
        highQualityURL <- map["highQualityURL"]
        lowQualityURL <- map["lowQualityURL"]
        posterURL <- map["posterURL"]
        processPlaylistURL <- map["processPlaylistURL"]
    }
    
}
