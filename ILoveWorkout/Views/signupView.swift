//
//  signupView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-15.
//

import SwiftUI
import FirebaseAuth

struct signupView: View {
    
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Welcome")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                Spacer()
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text:$email)
                    Spacer()
                    if(email.count != 0) {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text:$password)
                    Spacer()
                    if (password.count != 0) {
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                }
                Spacer()
                Button (action: signUp) {
                    Text("Create New Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)
                }
            }
        }
    }
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, authError in
            if let authError = authError {
                print(authError)
                return
            }
            if let authResult = authResult {
                userID = authResult.user.uid
            }
        }
    }
}
