//
//  HighScores+CoreDataProperties.swift
//  McCormickRobert_CE07
//
//  Created by Robert  McCormick on 23/01/2018.
//  Copyright © 2018 Robert  McCormick. All rights reserved.
//

import Foundation



import Foundation
import CoreData


extension HighScores {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScores> {
        return NSFetchRequest<HighScores>(entityName: "HighScores")
    }
    
    @NSManaged public var playerName: String?
    @NSManaged public var timeToComplete: String?
    @NSManaged public var numberOfTurns: Int32
    @NSManaged public var timestamp: NSDate?
    
}
