//
//  WorkoutView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-06.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct WorkoutView: View {
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    @State var workoutitems = [WorkoutItem]()
    @State var logoutOptions = false
    
    var body: some View {
        NavigationView {
            VStack() {
                List {
                    ForEach(workoutitems) {workoutitems in
                        HStack {
                            Text(workoutitems.name)
                            Spacer()
                            Button(action: {
                                if let user = currentUser {
                                    if let documentid = workoutitems.id {
                                        db.collection("users").document(user.uid).collection("exercises").document(documentid).updateData(["done": !workoutitems.done])
                                    }
                                }
                            }) {
                                Image(systemName: workoutitems.done ? "checkmark.square" : "square")
                            }
                        }
                    }.onDelete() { indexSet in
                        for index in indexSet {
                            let workoutitem = workoutitems[index]
                            if let id = workoutitem.id
                            {
                                deleteExerciseFromFireStore(id: id)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Exercise List")
                .navigationBarItems(trailing: NavigationLink(destination: ButtonView())
                                    {
                    Image(systemName: "plus.circle")
                        .transition(.move(edge: .bottom
                                         ))
                })
            
                .onAppear() {
                    listenToFirestore()
                }
                .padding()
        }
    }
    //Deletes exercise from firestore
    func deleteExerciseFromFireStore(id: String) {
        let user = Auth.auth().currentUser
        db.collection("users").document(user?.uid ?? "").collection("exercises").document(id).delete()
    }
    //Reads firebase workout data
    func listenToFirestore() {
        if let currentUser {
            db.collection("users").document(currentUser.uid).collection("exercises").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    workoutitems.removeAll()
                    for document in snapshot.documents {
                        
                        let result = Result {
                            try document.data(as: WorkoutItem.self)
                        }
                        switch result  {
                        case .success(let workoutitem)  :
                            workoutitems.append(workoutitem)
                        case .failure(let error) :
                            print("Error decoding workoutitem: \(error)")
                        }
                    }
                }
            }
        }
    }
}
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
