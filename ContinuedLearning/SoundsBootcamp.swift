//
//  SoundsBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI
import AVKit

enum SoundOption: String {
    case tada
    case badum
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf:url)
            player?.play()
        }catch let error{
            print(error.localizedDescription, "error playing sound")
        }
        
    }
    
}

struct SoundsBootcamp: View {
    var soundManager = SoundManager.instance
    var body: some View {
        VStack(spacing: 40) {
            Button("play sound 1") {
                soundManager.playSound(sound: .tada)
            }
            Button("play sound 2") {
                soundManager.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
