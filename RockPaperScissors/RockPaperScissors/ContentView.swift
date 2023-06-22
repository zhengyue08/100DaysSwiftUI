//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yue ZHENG on 6/21/23.
//

import SwiftUI

struct Move: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
    
            .padding()
            .background(.regularMaterial)
            .cornerRadius(20)

            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 5)
            )
            .shadow(radius: 5)
    }
}

extension View {
    func moveStyle() -> some View {
        modifier(Move())
    }
}

struct ContentView: View {
    let options = ["🖐️","✌️","✊"]
    let shouldWin = ["🖐️": "✌️","✌️": "✊","✊": "🖐️"]
    let shouldLose = ["✌️": "🖐️","✊": "✌️","🖐️": "✊"]

    let winOrlose = ["Win", "Lose"]
    let numberOfQuestions = 10
    @State private var choose = ["🖐️","✌️","✊"].randomElement() ?? "🖐️"
    
    @State private var correct: Bool = false
    
    @State private var indexOfQuestion = 0
    
    @State private var score = 0
    
    @State private var completedOneSet: Bool = false
    
    @State private var vs = ["Win", "Lose"].randomElement() ?? "Win"
    
    
    var body: some View {
        ZStack {

            VStack{
                Spacer()


                Text("⭐️ Tap the Correct Move ⭐️")
                    .font(.headline).bold()

                
                VStack {

                    Spacer()
                    Spacer()


                    VStack {

                        Text(choose)
                            .moveStyle()
                            .font(.largeTitle)

                    }
//                    .border(.black)
                    .padding()
                    Spacer()


                    VStack {

                        Spacer()

                        Text(vs)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(
                                (vs == "Win") ?
                                Color(uiColor: UIColor(red: 0, green: 0.7176, blue: 0, alpha: 1.0)) /* #00b700 */
                                : Color(uiColor: UIColor(red: 0.7176, green: 0, blue: 0, alpha: 1.0)) /* #b70000 */
                            )
                            .frame(width: 150, height: 60)
        //                    .padding(20)
                            .background(.regularMaterial)
                            .padding(10)
                            .background( (vs == "Win") ?
                                         Color(uiColor: UIColor(red: 0, green: 0.7176, blue: 0, alpha: 1.0)) /* #00b700 */
                                         : Color(uiColor: UIColor(red: 0.7176, green: 0, blue: 0, alpha: 1.0)) /* #b70000 */)
                            .padding()

                        Spacer()

                        HStack {
                            ForEach(options, id: \.self) { option in
                                Button {
                                    ifCorrect(userChoice: option)
                                    nextQuestion()
                                } label: {
                                    Text(option)
                                        .moveStyle()
                                }
                                .padding()

                            }
                        }
//                        .border(Color.black)
                        Spacer()


                    }
                    .background(AngularGradient(colors: [.red, .green, .blue, .purple, .pink], center: .center)
                        .ignoresSafeArea()
                        .opacity(0.8)).cornerRadius(10)
                        .padding()
                    
                    Spacer()


                }
                .background(Color.gray.opacity(0.2))
//                .background(Color(uiColor: UIColor(red: 0.0863, green: 0.5294, blue: 0, alpha: 1.0))) /* #168700 */
                .border(.brown, width: 2)
                .padding()
                .border(.brown, width: 5)
                .padding()
                .alert("Completed One Set", isPresented: $completedOneSet)
                {
                    Button ("Next Set") {
                        nextSet()
                    }
                } message: {
                    Text ("Score: \(score)")
                }


            }
            .shadow(radius: 20)
        }

    }
    
    
    func ifCorrect(userChoice: String) {
        if (vs == "Win" && shouldWin[choose] == userChoice) || (vs == "Lose" && shouldLose[choose] == userChoice) {
            correct = true
            score += 1
        } else {
            correct = false
            score = score
        }
    }
    func nextQuestion() {
        if indexOfQuestion == numberOfQuestions - 1 {
            completedOneSet = true

        }else {
            completedOneSet = false
            choose = options.randomElement() ?? "🖐️"
            indexOfQuestion += 1
            vs = winOrlose[indexOfQuestion % 2]
        }
    }
    func nextSet() {
        indexOfQuestion = 0
        choose = options.randomElement() ?? "🖐️"
        vs = winOrlose.randomElement() ?? "Lose"
        completedOneSet = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
