import SwiftUI

struct JoinView: View {
    @State private var searchText = ""
    @EnvironmentObject var meetingData: MeetingData
    @State private var joinedMeetings: [UUID: Bool] = [:]

    var filteredMeetings: [StudyGroupInfo] {
        if searchText.isEmpty {
            return meetingData.meetings
        } else {
            return meetingData.meetings.filter { meeting in
                // Make sure this closure returns a Bool
                meeting.hostName.lowercased().contains(searchText.lowercased()) ||
                meeting.location.lowercased().contains(searchText.lowercased()) ||
                (meeting.isSectionSelected && meeting.sectionText.lowercased().contains(searchText.lowercased())) ||
                (meeting.isOpenToAllSelected && "open to all".lowercased().contains(searchText.lowercased()))
            }
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for study groups", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Text("Current Meetings Available: ").bold()

                List(filteredMeetings, id: \.id) { meeting in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Host: \(meeting.hostName)")
                            Spacer()
                            if meeting.isSectionSelected {
                                Text("Section: \(meeting.sectionText)")
                            } else if meeting.isOpenToAllSelected {
                                Text("Open to All")
                            }
                        }
                        .padding(.bottom, 2)

                        Text("Class: \(meeting.className)")
                        Text("Time: \(meeting.startTime) - \(meeting.endTime)")
                        Text("Date: \(meeting.date)")
                        Text("Location: \(meeting.location)")
                        Text("Spots Remaining: \(meeting.participants)")

                        if let participantsCount = Int(meeting.participants), participantsCount > 0 {
                            if !(joinedMeetings[meeting.id] ?? false) {
                                Button("Join") {
                                    joinMeeting(meeting: meeting)
                                }
                                .styledAsJoinButton()
                            } else {
                                Text("Joined").styledAsJoinButton(background: .blue)
                            }
                        } else {
                            Text("Full").styledAsJoinButton(background: .red)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Join a Study Group")
        }
    }

    func joinMeeting(meeting: StudyGroupInfo) {
        // Your joinMeeting logic...
    }
}

extension View {
    func styledAsJoinButton(background: Color = .green) -> some View {
        self.frame(width: 80, height: 30)
            .background(background)
            .foregroundColor(.white)
            .cornerRadius(10)
            .bold()
    }
}
