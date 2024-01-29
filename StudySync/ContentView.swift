//
//  ContentView.swift
//  Study_Sync
//
//  Created by Connie Ly on 1/8/24.
//

import SwiftUI

struct ContentView: View {
   
    @State private var isHostingViewActive = false
    @State private var isJoiningViewActive = false
    @State private var isManageViewActive = false
    //testing nav code
    @State private var navigationPath = NavigationPath()
    @EnvironmentObject var navigationController: NavigationController
  
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            VStack {
               
                
                HStack {
                    Button("Host a Study Group") {
                        
                        isHostingViewActive = true
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $isHostingViewActive) {
                        HostingView()}
                    
                    Button("Join a Study Group") {
                        isJoiningViewActive = true
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $isJoiningViewActive) {
                        JoinView()}
                    
                    Button("Manage Study Groups") {
                        isManageViewActive = true
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $isManageViewActive) {
                        ManageView()}
                    
                }
                }
                .padding(.horizontal)
                Spacer()
              
            .navigationTitle("StudySync")
           
        }
    }
}

