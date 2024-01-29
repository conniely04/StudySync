//
//  MeetingData.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import Foundation

class MeetingData: ObservableObject {
    @Published var meetings: [StudyGroupInfo] = []

    init() {
        // Preloaded meetings
        let preloadedMeetings = [
            StudyGroupInfo(
                id: UUID(),
                hostName: "Jonathan",
                hostLastname: "Nguyen",
                className: "Calculus III",
                isSectionSelected: true,
                isOpenToAllSelected: false,
                sectionText: "3",
                date: "01-03-2024",
                location: "MLK Library",
                startTime: "3:00 PM",
                endTime: "5:00 PM",
                participants: "10",
                meetingDescription: "Study session for midterm exam"
            ),
            StudyGroupInfo(
                id: UUID(),

                hostName: "Cassie",
                hostLastname: "Ly",
                className: "Biology",
                isSectionSelected: true,
                isOpenToAllSelected: true,
                sectionText: "5",
                date: "01-13-2024",
                location: "MLK Library",
                startTime: "12:00 PM",
                endTime: "1:00 PM",
                participants: "5",
                meetingDescription: "Biology Exam Review"
            ),
            StudyGroupInfo(
                id: UUID(),

                hostName: "Cinnie",
                hostLastname: "Ly",
                className: "History",
                isSectionSelected: false,
                isOpenToAllSelected: true,
                sectionText: "9",
                date: "01-02-2024",
                location: "MLK Library",
                startTime: "2:00 PM",
                endTime: "5:00 PM",
                participants: "20",
                meetingDescription: "History Exam Review"
            ),
            StudyGroupInfo(
                id: UUID(),

                hostName: "Connie",
                hostLastname: "Ly",
                className: "English",
                isSectionSelected: true,
                isOpenToAllSelected: false,
                sectionText: "2",
                date: "01-18-2024",
                location: "MLK Library",
                startTime: "12:00 PM",
                endTime: "1:00 PM",
                participants: "1",
                meetingDescription: "Essay Peer Review"),
            
        ]

        self.meetings = preloadedMeetings
    }

    func hostMeeting(info: StudyGroupInfo) {
        meetings.append(info)
    }
}

