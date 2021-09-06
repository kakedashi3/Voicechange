//
//  Audio.swift
//  Voicechange
//
//  Created by 立岡力 on 2021/09/05.
//

import UIKit
import AVFoundation

final class Audio {
    
    var audioRecoder: AVAudioRecorder!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioUnitTimePitch: AVAudioUnitTimePitch!
    
    init() {}

    func setUpAudioRecorder() {
        let session =  AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecoder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecoder.delegate = self as? AVAudioRecorderDelegate
        } catch let errer {
            print(error)
        }
    
    }
    
    func playSound(speed: Float, pitch: Float, echo) -> <#return type#> {
        <#function body#>
    }
    
    
    
}
