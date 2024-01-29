//
//  SummaryView.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import SwiftUI



struct SummaryView: View {
    var studyGroupInfo: StudyGroupInfo
    @EnvironmentObject var navigationController: NavigationController
    
    var isSectionSelected: Bool
    var isOpenToAllSelected: Bool
   
    @Binding var navigateToSummary: Bool
    
   

    var body: some View {
        List {
            Section(header: Text("Study Group Summary").bold()) {
                Text("Host Name: \(studyGroupInfo.hostName)")
                Text("Host Last Name: \(studyGroupInfo.hostLastname)")
              
                Text("Class: \(studyGroupInfo.className)")
                
                if isSectionSelected {
                                  Text("Section: \(studyGroupInfo.sectionText)")

                              }
                              else if isOpenToAllSelected {
                                  Text("Open to All")
                              }

                Text("Date: \(studyGroupInfo.date)")
                Text("Location: \(studyGroupInfo.location)")
                Text("Start Time: \(studyGroupInfo.startTime)")
                Text("End Time: \(studyGroupInfo.endTime)")
                Text("Participants: \(studyGroupInfo.participants)")
                Text("Description: \(studyGroupInfo.meetingDescription)")
            }
        }
        .navigationTitle("Successfully Hosted!")
        .onDisappear {
                    navigateToSummary = false
                }
        
        
      
    }
    
    
}
