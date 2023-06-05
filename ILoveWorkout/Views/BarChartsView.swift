//
//  BarChartsView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-02-16.
//

import SwiftUI
import Charts
import Firebase
import FirebaseAuth
import Foundation


struct BarChartsView: View {
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    
    @State var workoutCounter = [WorkoutItem]()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text("Exercises Counter")
            
            Text("Total: \(workoutCounter.reduce(0, { $0 + $1.workoutCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            Chart {
                RuleMark(y: .value("Goal", 200))
                    .foregroundStyle(Color.black)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                
                ForEach(workoutCounter, id: \.self) { workoutcounter in
                    BarMark(
                        x: .value("Month", workoutcounter.date, unit: .month),
                        y: .value("WorkoutCount", workoutcounter.workoutCount)
                    )
                    .foregroundStyle(Color.red.gradient)
                    .cornerRadius(10)
                }
            }
            .frame(height: 180)
            .chartYScale()
            .chartXAxis {
                AxisMarks(values: workoutCounter.map {$0.date}) { date in
                    AxisValueLabel(format:
                            .dateTime.month(.narrow),
                                   centered: true)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            HStack {
                Image(systemName: "line.diagonal")
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundColor(.black)
                
                Text("Monthly Goal")
                    .foregroundColor(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
        }
        .onAppear() {
            listenToFirestore()
        }
        .padding()
    }
    
    func listenToFirestore() {
        if let currentUser {
            db.collection("users").document(currentUser.uid).collection("exercises").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    workoutCounter.removeAll()
                    for document in snapshot.documents {
                        
                        let result = Result {
                            try document.data(as: WorkoutItem.self)
                        }
                        switch result  {
                        case .success(let workoutcount)  :
                            workoutCounter.append(workoutcount)
                        case .failure(let error) :
                            print("Error decoding workoutitem: \(error)")
                        }
                    }
                }
            }
        }
    }
}
extension Date {
    static func from(month: Int) -> Date {
        let components = DateComponents(month: month)
        return Calendar.current.date(from: components)!
    }
}

