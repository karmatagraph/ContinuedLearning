//
//  HapticBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

class HapticManager {
    //this is our singleton
    static let instance = HapticManager()
    
    func notification (type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct HapticBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("succeess") {HapticManager.instance.notification(type: .success)}
            Button("warning") {HapticManager.instance.notification(type: .warning)}
            Button("error") {HapticManager.instance.notification(type: .error)}
            Divider()
            Button("soft") {HapticManager.instance.impact(style: .soft)}
            Button("light") {HapticManager.instance.impact(style: .light)}
            Button("medium") {HapticManager.instance.impact(style: .medium)}
            Button("rigid") {HapticManager.instance.impact(style: .rigid)}
            Button("heavy") {HapticManager.instance.impact(style: .heavy)}
        }
    }
}

struct HapticBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticBootcamp()
    }
}
