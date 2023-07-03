//
//  ContentView.swift
//  Animation
//
//  Created by Yue ZHENG on 2023/7/2.
//

import SwiftUI

struct Grid: ViewModifier {
    func body(content: Content) -> some View {
//        GeometryReader { geometry in
            content
            .frame(maxWidth: 150, maxHeight: 150)
                .padding()
                .border(.black)
//        }
    }
}

extension View {
    func gridStyle() -> some View {
        modifier(Grid())
    }
}

struct BasicCircleButton: View {
//    @State var animationAmount: Double
    let buttonText: String
    let animationAmountFunction: ()->Void

    
    var body: some View {
        Button(buttonText){
            animationAmountFunction()
        }
        .bold()
        .padding(50)
        //        .clipShape(Circle()) make no sense
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.orange, lineWidth: 10)
        )
    }
}

struct TapToScale: View {
    @State private var animationAmount:Double = 1.0

    var body: some View {
        
        ZStack{
            BasicCircleButton(buttonText: "Tap", animationAmountFunction: {
                animationAmount += 1
            })
            .scaleEffect(animationAmount)
            .animation(.easeInOut(duration: 0.5)
                       , value: animationAmount)
        }

    }
    
}

struct TapToScaleBounce: View {
    @State private var animationAmount = 1.0

    var body: some View {
        BasicCircleButton(buttonText: "Tap", animationAmountFunction: {
            animationAmount += 1
        })
        .scaleEffect(animationAmount)
        .animation(
            .interpolatingSpring(stiffness: 20, damping: 1),
            value: animationAmount
        )

    }
}

struct TapMe: View {
    @State private var animationAmount = 1.0
    var body: some View {
        ZStack{
            BasicCircleButton(buttonText:"Tap Me", animationAmountFunction: {
            })
            .overlay {
                Circle()
                    .stroke(.red, style: StrokeStyle(lineWidth: 2, dash: [4,0.5]))
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: animationAmount)
            }
            .onAppear{
                animationAmount = 2
            }
        }

    }
    
}

struct TapToChangeShape: View {
    @State private var change = false
    var body: some View {
        ZStack{
            Button("Tap to Change"){
                change.toggle()
            }
            .padding(30)
            .background(change ? .blue : .orange)
            .foregroundColor(.white)
            .bold()
            
            //MARK: Can't use change ? Circle() : RoundedRectangle
            .clipShape(RoundedRectangle(cornerRadius: change ? 10 : 50))
                    
            .animation(.default, value: change)
        }

    }
    
}

struct SwipeToSpin: View {
    @State private var spinDegree :Double = 0.0
    @State private var dragAmount = CGSize.zero
    var body: some View {
        ZStack{
            VStack{
                Circle()
                    .frame(width: 100).background {
                        RadialGradient(colors: [.orange, .orange, .orange, .blue, .purple, .pink], center: .center, startRadius: 0, endRadius: 190).clipShape(Circle())
                    }
                    .foregroundColor(Color(white: 1, opacity: 0))
                    .rotation3DEffect(.degrees(spinDegree), axis: (x: 0, y: 1, z: 0))
                    .gesture(
                        DragGesture()
                            .onChanged{
                                dragAmount = $0.translation
                                spinDegree = dragAmount.width
                            }
                            .onEnded{ _ in
                                if dragAmount.width < 0{
                                    print(dragAmount.width)
                                    //                            spinDegree = -(360 + spinDegree)
                                    spinDegree = -360
                                }else {
                                    spinDegree = +360
                                }
                            }
                    )
                    .animation(.interpolatingSpring(stiffness: 5, damping: 1), value: spinDegree)
                //            Text(dragAmount.width, format: .number)
                //            Text(spinDegree, format: .number)
            }
        }
    }
//    print(spinDegree)
}

struct BindScale: View {
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack{
            VStack {
                Stepper("Scale: \(scaleAmount.formatted())", value: $scaleAmount.animation(.easeInOut(duration: 1)), in: 1...5, step:0.5)
                Circle()
                    .frame(width: 100)
                    .foregroundColor(.blue)
                    .scaleEffect(scaleAmount)

            }
        }

    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack{
                TapToScale()
                    .gridStyle()
                TapToScaleBounce()
                    .gridStyle()

            }
            Spacer()
            HStack {
                TapMe()
                    .gridStyle()

                TapToChangeShape()
                    .gridStyle()
            }
            Spacer()
            HStack {
                SwipeToSpin()
                    .gridStyle()

                BindScale()
                    .gridStyle()
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        TapToScale()
//        TapToScaleBounce()
//        TapMe()
//        TapToChangeShape()
//        SwipeToSpin()
//        BindScale()
        ContentView()
    }
}
