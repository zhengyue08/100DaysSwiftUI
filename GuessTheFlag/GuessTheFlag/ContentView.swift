//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yue ZHENG on 6/14/23.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctIndex = Int.random(in: 0...3)
    
    @State private var correct = false
    
    @State private var tryAgain = false
    
    @State private var showAlert = false
    
    @State private var alertTitle = ""
    
    @State private var tryTimes = 0
    
    @State private var message = ""
    
    @State private var score = 0
    
    let numberOfQuestions = 10
    
    @State private var answeredQuestions = 0
    
    @State private var finished: Bool = false
    
    @State private var rotateAngle = [0.0, 0.0, 0.0, 0.0]
    @State private var opacity = [1.0, 1.0, 1.0, 1.0]
    @State private var scaleAnimate = [1.0, 1.0, 1.0, 1.0]


    var body: some View {
        
        ZStack {
            AngularGradient(colors: [.red, .green, .blue, .purple, .pink], center: .center)
                .ignoresSafeArea()
                .opacity(0.8)

            VStack{
                Text("Choose the Flag of")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text(countries[correctIndex])
                    .font(.largeTitle.bold())
                VStack(spacing: 10) {
                    ForEach(0..<4) {number in
                        Button {
                            tapAction(index: number, correctIndex: correctIndex)
                        } label: {
//                            Image(countries[number])
//                                .cornerRadius(10)
//                                .shadow(radius: 5)
                            FlagImage(country: countries[number])
                                
                        }
                        .opacity(opacity[number])
                        .scaleEffect(scaleAnimate[number])
                        .rotation3DEffect(.degrees(rotateAngle[number]), axis: (x: 0, y: 1, z: 0))
                        .animation(.interpolatingSpring(stiffness: 3, damping: 1), value: rotateAngle[number])
                        .animation(.easeOut, value: scaleAnimate)
                        .animation(.default, value: opacity[number])

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
//                .foregroundStyle(.secondary)
                .background(.regularMaterial)
                .cornerRadius(10)
                .alert(alertTitle, isPresented: $showAlert)
                {
                    if correct || (!correct && !tryAgain){
                        // next Question
                        Button("Continue") {
                            nextQuestion()
                        }
                    } else {
                        // try again
                        Button("Again") {
                            showAlert = false
                            tryTimes += 1
                        }
                    }
                } message: {
                    Text (message)
                }

                Text("Score: \(score)")
                    .font(.largeTitle.bold())
            }
            .padding(.horizontal, 10)
            .alert("Finished", isPresented: $finished) {
                Button("Next Set"){
                    nextSet()
                }
            }
        }
    }
    
    func tapAction (index: Int, correctIndex: Int) {
        if index == correctIndex {
            correct = true
            tryAgain = false
            alertTitle = "True"
            message = "Congratulation🥳, you got it"
            score += 1
        } else {
            if (index != correctIndex) && (tryTimes < 0) {
                correct = false
                tryAgain = true
                alertTitle = "False"
                message = "You can try again"
            } else {
                correct = false
                tryAgain = false
                alertTitle = "False"
                message = "Sorry, you missed a point"
            }
        }
        rotateAngle[index] += 360
        for num in 0..<4 {
            if  num != index {
                opacity[num] -= 0.5
                scaleAnimate[num] -= 0.2
            }
        }
        showAlert = true
        print(finished)
    }
    
    func nextQuestion () {
        countries.shuffle()
        correctIndex = Int.random(in: 0...3)
        tryTimes = 0
        if answeredQuestions == numberOfQuestions-1 {
            finished = true
        } else {
            answeredQuestions += 1
        }
        
        for num in 0..<4 {
            opacity[num] = 1.0
        }
        for num in 0..<4 {
            scaleAnimate[num] = 1.0
        }
    }
    
    func nextSet () {
        countries.shuffle()
        correctIndex = Int.random(in: 0...3)
        tryTimes = 0
        answeredQuestions = 0
        finished = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
