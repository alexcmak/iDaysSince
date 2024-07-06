//
//  iDaysSinceApp.swift
//  iDaysSince
//
//  Created by Alex Mak on 7/4/24.
//

import SwiftUI

@main
struct iDaysSinceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Event.self)
    }
}
