//
//  DragGestureBootcampII.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct DragGestureBootcampII: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            MySignupView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded {value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                    
                                }else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                }
                                else {
                                    currentDragOffsetY = 0
                                }
                            }
                        }
                )
//            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea( edges: .bottom)
        
    }
}

struct DragGestureBootcampII_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcampII()
    }
}

struct MySignupView: View {
    var body: some View {
        VStack(spacing:20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("this is me, this is us who he when do that and for what description to lorem ipsum")
                .multilineTextAlignment(.center)
            Text("create an account")
                .foregroundColor(Color.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.black)
                .cornerRadius(10)
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
