//
//  Study_SyncApp.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import SwiftUI

@main
struct Study_SyncApp: App {
    var meetingData = MeetingData()
    var navigationController = NavigationController()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(meetingData)
            .environmentObject(navigationController)
            .environmentObject(MeetingData())
        }
    }
}
