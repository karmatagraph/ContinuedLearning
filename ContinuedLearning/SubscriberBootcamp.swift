//
//  SubscriberBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textfieldText = ""
    @Published var isValid: Bool = false
    @Published var showButton: Bool = false
    
    
    init() {
        setupTimer()
        addTextfieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextfieldSubscriber() {
        $textfieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map {text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.isValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.isValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1,
                     on: .main,
                     in: .common)
            .autoconnect()
            .sink { [weak self]_ in
                guard let self = self else {
                    return
                }
                self.count += 1
                if self.count >= 100 {
                    for item in self.cancellables {
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $isValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else {
                    return
                }
                if isValid && count > 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
//            Text(vm.isValid.description)
            
            
            TextField("Type something...",text: $vm.textfieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.thinMaterial)
                .cornerRadius(10)
                .overlay(
                    ZStack{
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textfieldText.count < 1 ? 0.0 :
                                vm.isValid ? 0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.isValid ? 1.0 : 0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    ,alignment: .trailing
                    
                )
                
        }
        .padding()
        
        Button {
            
        } label: {
            Text("submit".uppercased())
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .opacity(vm.showButton ? 1.0 : 0.5)
        }
        .padding()
        .disabled(!vm.showButton)

    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
