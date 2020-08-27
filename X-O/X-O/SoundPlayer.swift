//
//  SoundPlayer.swift
//  X-O
//
//  Created by Haider Alboloushi on 8/28/20.
//  Copyright © 2020 Haider. All rights reserved.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }
        catch{
            
        }
    }
}

