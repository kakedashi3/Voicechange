//
//  Audio.swift
//  Voicechange
//
//  Created by 立岡力 on 2021/09/05.
//

import UIKit
import AVFoundation

final class Audio {
    
    // 録音と再生関連を宣言する
    var audioRecorder: AVAudioRecorder!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioUnitTimePitch: AVAudioUnitTimePitch!
    
    init() {}
    
    func setUpAudioRecorder() {
        let session = AVAudioSession.sharedInstance()
        
        // 例外処理
        do {
            try session.setCategory(
                .playAndRecord,
                mode: .default,
                // オプションの内容は[]で閉じると良い
                options: [.defaultToSpeaker,      // 録音レベルを大きくする
                          .allowAirPlay,          // AirPlayデバイスにストリーミングできる
                          .allowBluetoothA2DP])   // Bluetoothイヤホンでも録音再生ができる
            
            try session.setActive(true)
            
            // 音源の設定
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecorder.delegate = self as? AVAudioRecorderDelegate
            
        } catch let error {
            print(error)
        }
    }
    
    func playSound(speed: Float, pitch: Float, echo: Bool, reverb: Bool) {
        audioEngine = AVAudioEngine()
        
        let url = getAudioFileUrl()
        
        // 例外処理
        do {
            audioFile = try AVAudioFile(forReading: url)
            
            // ノードを生成エンジンにアタッチ
            audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attach(audioPlayerNode)
            
            // ノードを生成エンジンにアタッチ
            audioUnitTimePitch = AVAudioUnitTimePitch()
            audioUnitTimePitch.rate = speed
            audioUnitTimePitch.pitch = pitch
            audioEngine.attach(audioUnitTimePitch)
            
            // ノードを生成エンジンにアタッチ
            let echoNode = AVAudioUnitDistortion()
            echoNode.loadFactoryPreset(.multiEcho1)
            audioEngine.attach(echoNode)
            
            // ノードを生成エンジンにアタッチ
            let reverbNode = AVAudioUnitReverb()
            reverbNode.loadFactoryPreset(.cathedral)
            reverbNode.wetDryMix = 50
            audioEngine.attach(reverbNode)
            
            // 条件分岐
            if echo && reverb {
                connectAudioNodes(audioPlayerNode, audioUnitTimePitch, echoNode, reverbNode, audioEngine.outputNode)
            } else if echo {
                connectAudioNodes(audioPlayerNode, audioUnitTimePitch, echoNode, audioEngine.outputNode)
            } else if reverb {
                connectAudioNodes(audioPlayerNode, audioUnitTimePitch, reverbNode, audioEngine.outputNode)
            } else {
                connectAudioNodes(audioPlayerNode, audioUnitTimePitch, audioEngine.outputNode)
            }
            
            audioPlayerNode.stop()
            audioPlayerNode.scheduleFile(audioFile, at: nil)
            
            try audioEngine.start()
            audioPlayerNode.play()
        } catch let error {
            print(error)
        }
    }
    
    private func connectAudioNodes(_ nodes: AVAudioNode...) {
        for x in 0..<nodes.count - 1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
    // URLを取得するメソッド
    private func getAudioFileUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.m4a")
        
        return audioUrl
    }
}
