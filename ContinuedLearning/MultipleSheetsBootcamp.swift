//
//  MultipleSheetsBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI
struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// use binding
// multiple.sheets
// item approach

struct MultipleSheetsBootcamp: View {
    @State var selectedModel: RandomModel? // = RandomModel(title: "Starting title")
//    @State var showSheet: Bool = false
//    @State var showSheet2: Bool = false
//
    var body: some View {
        VStack(spacing: 20) {
            Button("Button1") {
                selectedModel = RandomModel(title: "one")
//                showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                nextScreen(selectedModel: RandomModel(title: "one"))
//            }
            Button("Button2") {
                selectedModel = RandomModel(title: "two")
//                showSheet2.toggle()
            }
//            .sheet(isPresented: $showSheet2) {
//                nextScreen(selectedModel: RandomModel(title: "two"))
//            }
        }
        .sheet(item: $selectedModel) { model in
            nextScreen(selectedModel: model)
        }
//        .sheet(isPresented: $showSheet) {
//            nextScreen(selectedModel: selectedModel)
//        }
    }
}

struct nextScreen: View {
    let selectedModel: RandomModel
    var body: some View {
        Text("\(selectedModel.title)")
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
