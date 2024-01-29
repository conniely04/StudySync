//
//  HostingView.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import SwiftUI



struct HostingView: View {
    @EnvironmentObject var meetingData: MeetingData
    @State private var hostName: String = ""
    @State private var hostLastname: String = ""
    
    @State private var className: String = ""
    @State private var date: Date = Date()
    @State private var location: String = ""
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var participants: Int = 0
    @State private var meetingDescription: String = ""
    @State private var navigateToSummary = false
    
    @State private var newMeeting: StudyGroupInfo?
    //testing
    @State private var isSectionSelected = false
    @State private var isOpenToAllSelected = false
    @State private var sectionText = ""
    
    
    var isFormValid: Bool {
        // Check if 'Section' is selected and if the section text is not empty
        let sectionCondition = isSectionSelected && !sectionText.isEmpty

        // The form is valid if all required fields are filled and either 'Open to All' is selected or 'Section' condition is met
        return !location.isEmpty
            && participants > 0
            && startTime < endTime
            && !meetingDescription.isEmpty
            && !hostName.isEmpty
            && !hostLastname.isEmpty
            && !className.isEmpty
            && (isOpenToAllSelected || sectionCondition)
    }

    
    
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Enter Study Group Details: ").bold()
                    .font(.system(size: 18))) {
                        //first name field
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Host Name *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            TextField("Host Name: ", text: $hostName) .padding([.leading], 18)
                                .padding([.bottom], 18)
                        }
                        .listRowInsets(EdgeInsets())
                        
                        //last name field
                        
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Host Last Name *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            TextField("Last Name: ", text: $hostLastname) .padding([.leading], 18)
                                .padding([.bottom], 18)
                        }
                        .listRowInsets(EdgeInsets())
                        
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Class *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            TextField("Class: ", text: $className) .padding([.leading], 18)
                                .padding([.bottom], 10)
                            Toggle(isOn: $isSectionSelected) {
                                    Text("Section: ")
                                }
                            .padding([.leading], 18).padding([.trailing], 18).bold()
                            if isSectionSelected {
                                    TextField("Enter Section: ", text: $sectionText)
                                    .padding([.leading], 18)
                                }

                                Toggle(isOn: $isOpenToAllSelected) {
                                    Text("Open to All")
                                }
                                .padding([.leading], 18) .padding([.bottom], 18).padding([.trailing], 18).bold()
                        }
                        .listRowInsets(EdgeInsets())
                        
                        //location field
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Location *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            TextField("Location: ", text: $location) .padding([.leading], 18)
                                .padding([.bottom], 18)
                        }
                        .listRowInsets(EdgeInsets())
                        
                  
                        
                        //date field
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Date *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            DatePicker("", selection: $date, displayedComponents: .date
                            ).padding([.leading], 90).padding([.trailing], 105).padding([.bottom], 20)
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                        
                        //meetingtime field
                        VStack {
                            Text("Enter Meeting Time *") .font(.headline).padding([.trailing], 150).padding([.top], 10)
                            Spacer().padding([.top], 8)
                            
                            VStack(alignment: .leading) {
                                Text("Start Time") // Label for start time
                                    .font(.subheadline)
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .frame(maxHeight: 20)
                            }.listRowInsets(EdgeInsets())
                                .padding([.leading], 12)
                            
                            Spacer() // Adds space between start and end time pickers
                            
                        }
                        VStack(alignment: .leading) {
                            Text("End Time") // Label for end time
                                .font(.subheadline)
                            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .frame(maxHeight: 20)
                        }
                        .padding([.leading], 12)
                        
                        //particpant field
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter # of Participants *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            Stepper("(Max 100): \(participants)", value: $participants, in: 0...100) .padding([.leading], 18) .padding([.bottom], 18).padding([.trailing], 18)
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                        //Meeting description field
                        VStack(alignment: .leading, spacing: 8) { // Adjust spacing as needed
                            Text("Enter Meeting Description *")
                                .font(.headline)
                                .foregroundColor(.primary) // Apply your color preference
                                .padding([.leading], 18).padding([.top], 10)
                            TextField("Description:", text: $meetingDescription) .padding([.leading], 18)
                                .padding([.bottom], 18)
                            Spacer()
                        }
                        .listRowInsets(EdgeInsets())

                        
                    }
                    .navigationTitle("Host a Study Group")
                
                //button
                Button("Host") {
                    if isFormValid {
                                           newMeeting = StudyGroupInfo(
                                            id: UUID(),
                                                hostName: hostName,
                                                hostLastname: hostLastname,
                                                className: className,
                                                isSectionSelected: isSectionSelected,
                                                isOpenToAllSelected: isOpenToAllSelected,
                                                sectionText: sectionText,
                                               date: formatDate(date: date),
                                               location: location,
                                               startTime: formatTime(time: startTime),
                                               endTime: formatTime(time: endTime),
                                               participants: String(participants),
                                               meetingDescription: meetingDescription
                                           )
                                           
                                           meetingData.hostMeeting(info: newMeeting!)
                        resetFormFields()
                                           navigateToSummary = true // This triggers the navigation
                        
                        print(isSectionSelected)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigateToSummary = false
                                }
                                       }
                    
                }
                .frame(width: 80, height: 20)
                .bold()
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(isFormValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(!isFormValid)

                
              
                
                NavigationLink(
                    destination: SummaryView(
                        studyGroupInfo: meetingData.meetings.last ?? StudyGroupInfo.default,
                        isSectionSelected: isSectionSelected,
                        isOpenToAllSelected: isOpenToAllSelected,
                        
                        navigateToSummary: $navigateToSummary // This should be a Binding
                    ),
                    isActive: $navigateToSummary
                ) {
                  
                    EmptyView()
                }.hidden().padding([.bottom], 10)


        }
            
           
        }
            
       
    }
    private func resetFormFields() {
        hostName = ""
        hostLastname = ""
        
        sectionText = ""
       
        className = ""
        date = Date()
        location = ""
        startTime = Date()
        endTime = Date()
        participants = 0
        meetingDescription = ""
        navigateToSummary = false
           
        }
    
    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy" // Format for month-date-year
        return dateFormatter.string(from: date)
    }

    
    private func formatTime(time: Date) -> String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: time)
        }
}



//make required info
//display ingo on summary page
//participant number

//after hosting 1 it wont let host mmore
