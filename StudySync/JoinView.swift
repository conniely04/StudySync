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
        VStack{
            TextField("Search for study groups", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationView {
                VStack {
                    VStack{
                       
                        Text("Current Meetings Available: ").bold()}
                    
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
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                
            }
            
        }.navigationTitle("Join a Study Group")}
        
    func joinMeeting(meeting: StudyGroupInfo) {
        // Check if the meeting has already been joined
        if joinedMeetings[meeting.id] == true {
            // Possibly handle already joined meeting
            print("You have already joined this meeting.")
            return
        }

        // Check if there are spots available
        if let participantsCount = Int(meeting.participants), participantsCount > 0 {
            // Decrease the number of participants by 1
            let newParticipantsCount = participantsCount - 1

            // Update the meeting with the new participants count
            if let index = meetingData.meetings.firstIndex(where: { $0.id == meeting.id }) {
                meetingData.meetings[index].participants = String(newParticipantsCount)
                // Mark the meeting as joined
                joinedMeetings[meeting.id] = true
            }
        } else {
            // Handle the case where no spots are available
            print("No spots available in this meeting.")
        }
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
