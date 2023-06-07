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
    @State var workoutitems = [WorkoutItem]()
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    let firebaseManager = FirebaseManager()
    
    var body: some View {
        NavigationView {
            VStack() {
                List {
                    ForEach(workoutitems, id: \.self) {workoutitem in
                        HStack {
                            Text(workoutitem.name + ", " + String(workoutitem.workoutCount))
                            Spacer()
                            Button(action: {
                                    if let documentid = workoutitem.id {
                                        firebaseManager.updateFireStoreCheckbox(documentid: documentid, workoutitem: workoutitem)
                                    }
                            }) {
                                Image(systemName: workoutitem.done ? "checkmark.square" : "square")
                            }
                        }
                    }.onDelete() { indexSet in
                        for index in indexSet {
                            let workoutitem = workoutitems[index]
                            if let id = workoutitem.id
                            {
                                firebaseManager.deleteExerciseFromFireStore(id: id)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Exercise List")
                .navigationBarItems(trailing: NavigationLink(destination: ButtonView()){
                    Image(systemName: "plus.circle")
                        .transition(.move(edge: .bottom))})
                .background(Color(.systemGroupedBackground))
                .onAppear() {
                    listenToFirestore()
                }
                .padding(.top, 20)
        }
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
