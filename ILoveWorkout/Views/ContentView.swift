//
//  ContentView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""

    var body: some View {
        
        if userID == "" {
            AuthView()
        } else {
            TabView {
                WorkoutView()
                    .tabItem() {
                        Image(systemName: "doc.text.below.ecg.fill")
                        Text("Workout")
                    }
                AuthView()
                    .tabItem() {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account")
                    }
                ProfileView()
                    .tabItem() {
                        Image(systemName: "gearshape.fill")
                        Text("Profile")
                    }
            }.navigationBarBackButtonHidden(true)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
