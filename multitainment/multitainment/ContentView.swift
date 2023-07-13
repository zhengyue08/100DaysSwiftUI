//
//  ContentView.swift
//  multitainment
//
//  Created by Yue ZHENG on 2023/7/5.
//

import SwiftUI

struct BasicButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 120, height: 40)
            .background(.black.opacity(80))
            .foregroundColor(.white)
            .bold()
            .clipShape(Capsule())
    }
}

struct ViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 350, height: 600)
            .background(.ultraThickMaterial)
            .cornerRadius(50)
            .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))
    }
}

extension View {
    func basicButtonStyle() -> some View {
        modifier(BasicButton())
    }
    func basicViewstyle() -> some View {
        modifier(ViewStyle())
    }
}

struct Question: Identifiable {
    let id = UUID()
    let firstMultiplier: Int
    let secondMultiplier: Int
    func answer() -> Int {
        return firstMultiplier * secondMultiplier
    }
}

struct PreGameView: View {
    
    @State private var lowest = 2
    @State private var highest = 12
    @State private var numberOfQuestions = 1
    
    @State var subViewNumber: Int
    
    @Binding var started: Bool
//
    
    var userRange: ClosedRange<Int> {
        return lowest...highest
    }
    
    
    @Binding var questions: [Question]
    
    @Binding var viewNumber: Int

    
    var body: some View {
        ZStack {
            if subViewNumber == 0 {
                VStack{
                    Text("Hey, 👋\nLet’s learn to Multiply\nby Playing")
                        .font(.custom("Comic Sans MS", size: 28))
                    Button ("Next >") {
                        subViewNumber += 1
                    }
                    .basicButtonStyle()
                }
                .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))

            } else if subViewNumber == 1 {
                VStack{
                    Text("First, we need to\nDo some settings ⚙️")
                        .font(.custom("Comic Sans MS", size: 28))
                    Button("Next >") {
                            subViewNumber += 1
                    }
                    .basicButtonStyle()

                }
                .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))

                    
            } else if subViewNumber == 2 {
                VStack {
                    Text("Pick a range of \nMultiplier").font(.custom("Comic Sans MS", size: 34))
                    HStack {
                        Picker("Start from", selection: $lowest) {
                            ForEach(userRange, id: \.self) { num in
                                Text("\(num)")
                                    .font(.custom("Comic Sans MS", size: 28))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 100)

                        Text("~")
                        Picker("Start from", selection: $highest) {
                            ForEach(userRange, id: \.self) { num in
                                Text("\(num)")
                                    .font(.custom("Comic Sans MS", size: 28))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 100)
                    }
                    VStack{
                        Text("Answer ? Questions")
                            .font(.custom("Comic Sans MS", size: 28))
                        
                        Picker("How many questions", selection: $numberOfQuestions) {
                            ForEach([1,5,10], id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.segmented)
                            .padding()
                    }
                    Button ("Start") {
                        startGame()
                    }
                    .basicButtonStyle()
                    
                }
                .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))

            }
        }
        .basicViewstyle()

        
    }
    func startGame(){
        questions.removeAll()
         
        //initiate questions
        initiateQuestions()
        viewNumber = 1
        started = true
    }
    
    func initiateQuestions() {
        for _ in 0..<numberOfQuestions{
            questions.append(Question(firstMultiplier: userRange.randomElement() ?? 0, secondMultiplier: userRange.randomElement() ?? 0))
        }
    }

}

struct GameView: View {
    
    let animals = ["🦊", "🐰", "🦁", "🐯", "🐭"]
        
    @State var questions: [Question]
    
    @State private var questionNumber = 0
    
    @Binding var viewNumber: Int
    
    var numberOfQuestions: Int {
        return questions.count
    }
    
    var question: Question {
        return questions[questionNumber]
    }
    
    @State private var userAnswer = Int()
    @State private var score = Int()
    
    // alert
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var thisAnimal = "🐰"
    
    var body: some View {
        ZStack {
            VStack{
                Text("How many \(thisAnimal)")
                    .font(.custom("Comic Sans MS", size: 32))
                Text("\(question.firstMultiplier) x \(question.secondMultiplier) x \(thisAnimal) = ")
                    .font(.custom("Comic Sans MS", size: 32))
                HStack {
                    TextField("Answer", value: $userAnswer, format: .number)
                        .font(.custom("Comic Sans MS", size: 32))
                        .frame(width: 100)
                        .keyboardType(.numberPad)
                    Text("x \(thisAnimal)")
                        .font(.custom("Comic Sans MS", size: 32))

                }
                Button ("Submit") {
                    playGame()
                }
                .basicButtonStyle()


            }
            .alert(alertTitle, isPresented: $showingAlert) {
               if questionNumber < numberOfQuestions-1{
                   Button("Next") {
                       nextQuestion()
                   }
               } else {
                   HStack{
                       Button ("Cancel") {
                           endGame()
                       }
                       Button ("Play Again") {
                           cleanQuestionSet()
                           viewNumber = 0
                       }
                   }
               }
           } message: {
               Text(alertMessage)
           }
        }
        .basicViewstyle()
    }
    
    func nextQuestion() {
        questionNumber += 1
        userAnswer = 0
        showingAlert = false
        thisAnimal = animals.randomElement() ?? "🦊"
    }
    
    func playGame() {
        if userAnswer == question.answer(){
            score += 1

        } else {
            score = score
        }
        
        aboutAlert()
    }
    
    func aboutAlert(){
        if questionNumber == numberOfQuestions-1{
            alertTitle = "You finished a set"
            alertMessage = "Your score: \(score)"
        } else {
            if userAnswer == question.answer(){
                alertTitle = "Correct"

            } else {
                alertTitle = "False"
                alertMessage = "\(question.firstMultiplier) x \(question.secondMultiplier) = \(question.answer())"
            }
        }
                                                                       
        showingAlert = true
    }
    
    func cleanQuestionSet() {
        questions = [Question(firstMultiplier: 0, secondMultiplier: 0)]
        questionNumber = 0
        score = 0
    }
    
    func endGame() {
        viewNumber = 2
    }

}

struct EndView: View {
    var body: some View {
        Text("End")
            .padding()
            .font(.largeTitle)
            .bold()
            .background(.thickMaterial)
    }
}

struct ContentView: View {
    
    @State private var viewNumber = 0


    @State private var questions = [Question(firstMultiplier: 0, secondMultiplier: 0)]
    
    @State private var started = false
        
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [.blue, .pink, .white, .purple, .blue], center: .center, startRadius: 10, endRadius: 500)
                .ignoresSafeArea()
            if viewNumber == 0{
                PreGameView(subViewNumber: started ? 2 : 0, started: $started, questions: $questions, viewNumber: $viewNumber)

            } else if viewNumber == 1 {
                GameView(questions: questions, viewNumber: $viewNumber)

            } else if viewNumber == 2 {
                EndView()

            }
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
