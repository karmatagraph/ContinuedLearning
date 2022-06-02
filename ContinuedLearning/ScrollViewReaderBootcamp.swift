//
//  ScrollViewReaderBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var textfieldText: String = ""
    @State var scrollToIndex: Int = 0
    var body: some View {
        VStack {
            TextField("enter a # here", text: $textfieldText)
                .padding()
                .frame(height: 55 )
                .border(.gray)
                .padding()
                .keyboardType(.numberPad)
            Button {
                withAnimation(.spring()) {
                    if let index = Int(textfieldText) {
                        scrollToIndex = index
                    }
                    
                    // proxy.scrollTo(30, anchor: .center)
                }
                
            } label: {
                Text("Scroll Now")
            }
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50){ number in
                        Text(" this is the \(number)th text")
                            .font(.headline)
                            .frame(height: 200 )
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(number)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
                
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
