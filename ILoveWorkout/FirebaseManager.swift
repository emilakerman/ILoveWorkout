//
//  FirebaseManager.swift
//  ILoveWorkout
//
//  Created by Emil Åkerman on 2023-06-07.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


struct FirebaseManager {
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    //Save excercise to firestore
    func saveExerciseToFireStore(workoutNameAndCount: String) {
        if let currentUser {
            db.collection("users").document(currentUser.uid).collection("exercises").addDocument(data:
               ["name" : workoutNameAndCount,
                "exercise" : "",
                "done": false,
                "date": Date(),
                "workoutCount": 1])
        }
    }
    //Updates the "done" check box
    func updateFireStoreCheckbox(documentid: String, workoutitem: WorkoutItem?) {
        if let currentUser {
            if let workoutitem {
                db.collection("users").document(currentUser.uid).collection("exercises").document(documentid).updateData(["done": !workoutitem.done])
            }
        }
    }
    //Deletes exercise from firestore
    func deleteExerciseFromFireStore(id: String) {
        if let currentUser {
            db.collection("users").document(currentUser.uid).collection("exercises").document(id).delete()
        }
    }
}
