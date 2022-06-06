//
//  EscapingClosureBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Helloo"
    
    func getData() {
//        downloadData3 { [weak self] returnedData in
//            self?.text = returnedData
//        }
        
        downloadData5 { [weak self]result in
            self?.text = result.data
        }
    }
    
    func downloadData() -> String {
        return "New Data!!"
    }
    
    func downloadData2(completionHandler: ( _ data: String) -> ()) {
        completionHandler("New data from closure")
    }
    
    func downloadData3(completionHandler: @escaping( _ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("NewDAta !!!! ")
        }
    }
    
    func downloadData4(completionHandler: @escaping(DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "NEW DATA 4")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "NEW DATA 5")
            completionHandler(result)
        }
    }
    
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct DownloadResult {
    let data: String
}

struct EscapingClosureBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingClosureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingClosureBootcamp()
    }
}
