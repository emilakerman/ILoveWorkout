//
//  WorkoutItem.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-06.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth


struct WorkoutItem : Codable, Identifiable, Hashable {
    @DocumentID var id : String?
    var name : String
    var exercise : String = ""
    var done : Bool = false
    var date : Date
    var workoutCount : Int = 1
}
