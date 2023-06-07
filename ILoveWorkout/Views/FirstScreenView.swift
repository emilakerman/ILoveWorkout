//
//  ContentView.swift
//  ILoveWorkout
//
//  Created by Jonas Backas on 2023-01-23.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct FirstScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height:
                                    proxy.size.height * 0.40)
                    Text("Workout Diary")
                        .font(.system(size: 59, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink (destination:
                                        ContentView(), isActive:
                                        $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.circle")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Text("Get started")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }.padding()
                        }
                    }
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Image("LoveWorkout")
                        .resizable()
                        .aspectRatio(
                            contentMode: .fill
                        )
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
