//
//  StudyGroupInfo.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import Foundation


struct StudyGroupInfo: Identifiable, Equatable {
    var id: UUID
    var hostName: String
    var hostLastname: String
    var className: String
    var isSectionSelected: Bool
    var isOpenToAllSelected: Bool
    var sectionText: String
    var date: String
    var location: String
    var startTime: String
    var endTime: String
    var participants: String
    var meetingDescription: String
    
    static var `default`: StudyGroupInfo {
         StudyGroupInfo(
             id: UUID(),
             hostName: "",
             hostLastname: "",
             className: "",
             isSectionSelected: false,
             isOpenToAllSelected: false,
             sectionText: "",
             date: "",
             location: "",
             startTime: "",
             endTime: "",
             participants: "",
             meetingDescription: "")

     }

     static func ==(lhs: StudyGroupInfo, rhs: StudyGroupInfo) -> Bool {
         return lhs.id == rhs.id
         // Add additional comparisons here if needed
     }
}
