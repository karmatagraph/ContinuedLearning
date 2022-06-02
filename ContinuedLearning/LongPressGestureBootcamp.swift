//
//  LongPressGestureBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isCompleted: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click here")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                        // at the min duration
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        // this is from start of press
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isCompleted.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isCompleted = false
                                    }
                                }
                            }
                            
                        }
                    }

                Text("Reset")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation {
                            isCompleted = false
                            isSuccess = false
                        }
                    }
            }
        }
        
        
        
        //        Text(isCompleted ? "Complete": "Not Complete")
        //            .padding()
        //            .padding(.horizontal)
        //            .background(isCompleted ? Color.green : Color.gray)
        //            .cornerRadius(10)
        ////            .onTapGesture {
        ////                isCompleted.toggle()
        ////            }
        //            .onLongPressGesture(minimumDuration: 2,maximumDistance: 1) {
        //                isCompleted.toggle()
        //            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
