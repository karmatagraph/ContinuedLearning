//
//  MagnificationGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State var amount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack {
            HStack{
                Circle()
                    .frame(width: 35, height: 35)
                Text("hola amigo")
                Spacer()
                Image(systemName: "elipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + amount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            amount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                amount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("this is the caption for my post")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            
        }
        
        
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //            .font(.title)
        //            .padding(40)
        //            .background(Color.red)
        //            .cornerRadius(10)
        //            .scaleEffect(1.0 + amount + lastAmount)
        //            .gesture(
        //                MagnificationGesture()
        //                    .onChanged { value in
        //                        amount = value - 1
        //                    }
        //                    .onEnded { value in
        //                        lastAmount += amount
        //                        amount = 0
        //                    }
        //            )
    }
}

struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
