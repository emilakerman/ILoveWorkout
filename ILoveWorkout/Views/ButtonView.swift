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
    @State var content : String = ""
    @Environment(\.presentationMode) var presentationMode
    
    let firebaseManager = FirebaseManager()
    
    var body: some View {
        Text("Enter workout name and amount")
        TextEditor(text: $content)
        .navigationBarItems(trailing: Button("Save") {
            firebaseManager.saveExerciseToFireStore(workoutNameAndCount: content)
            presentationMode.wrappedValue.dismiss()
        })
    }
}
