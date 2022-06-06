//
//  TimerBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI
class color{
//    #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
}
struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 0.50, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finished: String? = nil
    */
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour,.minute,.second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    */
    
    // Animation counter
    @State var count: Int = 0
    var body: some View {
        ZStack{
            RadialGradient(colors: [
                Color(.init(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
                Color(.init(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
            ],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            HStack (spacing: 15){
                Circle()
                    .offset(y: count == 1 ? -20 :0)
                Circle()
                    .offset(y: count == 2 ? -20 :0)
                Circle()
                    .offset(y: count == 3 ? -20 :0)
            }
            .frame(width: 150)
            .foregroundColor(.white)
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
//            updateTimeRemaining()
            withAnimation(.easeInOut(duration: 0.5)){
                count = count == 3 ? 0 : count + 1
            }
        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
