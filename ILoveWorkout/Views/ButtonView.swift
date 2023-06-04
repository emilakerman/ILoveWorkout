//
//  ButtonView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-09.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct ButtonView: View {
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    @State var content : String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextEditor(text: $content)
                .background(.gray)
                .onTapGesture {
                }
        }
        .navigationBarItems(trailing: Button("Save") {
            saveExerciseToFireStore(workoutName: content)
            presentationMode.wrappedValue.dismiss()
        })
    }
func saveExerciseToFireStore(workoutName: String) {
    if let currentUser {
        db.collection("users").document(currentUser.uid).collection("exercises").addDocument(data:
           ["name" : workoutName,
            "exercise" : "",
            "done": false,
            "date": Date(),
            "workoutCount": 1])
        }
    }
}
