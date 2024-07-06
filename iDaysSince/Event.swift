//
//  Event.swift
//  iDaysSince
//
//  Created by Alex Mak on 7/4/24.
//

import Foundation
import SwiftData

@Model
class Event {
    var event: String
    var date: Date
    
    init(event: String = "", date: Date = .now) {
        self.event = event
        self.date = date
    }
}

