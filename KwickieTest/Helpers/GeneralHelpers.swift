//
//  GeneralHelpers.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 18/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import Foundation


func getStringIntervalRepresentationFor(duration: Double) -> String {

    // Convert double to int
    let intRepresentation = Int(duration)
    
    // Calculate the days, hours and seconds
    let days = intRepresentation / 86400
    let hours = (intRepresentation % 86400) / 3600
    let minutes = (intRepresentation % 3600) / 60
    
    // Return the highest possible denomination
    if days > 0 {
        return "\(days) days ago"
    } else if hours > 0 {
        return "\(minutes) hours ago"
    } else if minutes > 0 {
        return "\(minutes) minutes ago"
    } else {
        return "Just now"
    }

}
