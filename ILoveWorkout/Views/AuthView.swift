//
//  AuthView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-15.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var currentViewShowing: String = "login" //login or signup
    
    var body: some View {
        if(currentViewShowing == "login") {
            loginView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            signupView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
