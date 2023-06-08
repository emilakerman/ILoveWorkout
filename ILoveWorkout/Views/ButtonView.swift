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
    @State var exerciseType: String = ""
    @State var exerciseAmount: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    let firebaseManager = FirebaseManager()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TextField("Enter workout type (e.g., pushups)", text: $exerciseType)
                TextField("Exercise amount of reps", text: $exerciseAmount)
                    .keyboardType(.numberPad)
                    .navigationBarItems(trailing: Button("Save") {
                        if let amount = Int(exerciseAmount) {
                            firebaseManager.saveExerciseToFirestore(exerciseType: exerciseType, exerciseAmount: amount)
                        }
                        presentationMode.wrappedValue.dismiss()
                    })
            }
            .frame(width: geometry.size.width * 0.8, height: nil)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
        }
        .background(Color.gray.opacity(0.2))
        .edgesIgnoringSafeArea(.all)
    }
}
