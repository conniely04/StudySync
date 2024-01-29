//
//  MeetingDescription.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/15/24.
import SwiftUI
//
struct MeetingDescriptionView: View {
    var meeting: StudyGroupInfo
    @EnvironmentObject var meetingData: MeetingData
    var updatedMeeting: StudyGroupInfo? {
            meetingData.meetings.first { $0 == meeting }
        }

    var body: some View {
        VStack {
            Text("Meeting Description")
                .font(.headline)
            // Display details about the meeting
                Text("Host: \(meeting.hostName) \(meeting.hostLastname)")
                Text("Class: \(meeting.className)")
                Text("Date: \(meeting.date)")
                Text("Time: \(meeting.startTime) - \(meeting.endTime)")
                Text("Location: \(meeting.location)")
                Text("Participants: \(meeting.participants)")
                Text("Description: \(meeting.meetingDescription)")            // Add more details as needed
            }
        .padding()
        .navigationTitle("Meeting Details")
        VStack{
            if Int(meeting.participants) ?? 0 > 0 {
                Button("Join") {
                    joinMeeting(meeting: meeting)
                    
                }
                .frame(width: 80, height: 30)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .bold()
            } else {
                Text("Full")
                    .frame(width: 80, height: 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .bold()
            }}
    }
    func joinMeeting(meeting: StudyGroupInfo) {
        if var participantsCount = Int(meeting.participants), participantsCount > 0 {
            participantsCount -= 1
            if let index = meetingData.meetings.firstIndex(where: { $0 == meeting }) {
                var updatedMeeting = meeting
                updatedMeeting.participants = String(participantsCount)
                meetingData.meetings[index] = updatedMeeting
            }
        }
    }
}

