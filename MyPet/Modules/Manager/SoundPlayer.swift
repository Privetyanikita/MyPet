//
//  SoundPlayer.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 13.03.25.
//

import AVFoundation

final class SoundPlayer {
    
    static let shared = SoundPlayer()
    private var music: AVAudioPlayer?
    
    private init() {}
    
    func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            music = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let music = music else { return }
            music.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func stopSound() {
        music?.stop()
    }
}
