//
//  ViewController.swift
//  Voicechange
//
//  Created by 立岡力 on 2021/09/01.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    
    // Audioクラスのインスタンスを作成
    var audio = Audio()
    
    
    // speedを変更するスライダー
    @IBOutlet weak var speedSlider: UISlider! {
        didSet {
            speedSlider.minimumValue = 0.5
            speedSlider.maximumValue = 1.5
            speedSlider.setValue(1, animated: true)
            speedSlider.tintColor = .purple
        }
    }
    
    // pitchを変更すrスライダー
    @IBOutlet weak var pitchSlider: UISlider! {
        didSet {
            pitchSlider.minimumValue = -1000
            pitchSlider.maximumValue = 1000
            pitchSlider.setValue(0, animated: true)
            pitchSlider.tintColor = .purple
        }
    }
    
    // echoスイッチ
    @IBOutlet weak var echoSwitch: UISwitch! {
        didSet {
            echoSwitch.isOn = false
            echoSwitch.onTintColor = .purple
            echoSwitch.tintColor = .purple
        }
    }
    
    // reverbスイッチ
    @IBOutlet weak var reverbSwitch: UISwitch! {
        didSet {
            reverbSwitch.isOn = false
            reverbSwitch.onTintColor = .purple
            reverbSwitch.tintColor = .purple
        }
    }
    
    // Recordボタン
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.layer.cornerRadius = recordButton.layer.bounds.height / 2
        }
    }
    
    // playボタン
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = playButton.layer.bounds.height / 2
            playButton.isEnabled = false
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // modelのメソッド
        audio.setUpAudioRecorder()
        
    }

    
    
    @IBAction func record(_ sender: Any) {
        if !audio.audioRecorder.isRecording {
            audio.audioRecorder.record()
        } else {
            audio.audioRecorder.stop()
            playButton.isEnabled = true
        }
    }
    
    
    @IBAction func play(_ sender: Any) {
        audio.playSound(speed: speedSlider.value,
                        pitch: pitchSlider.value,
                        echo: echoSwitch.isOn,
                        reverb: reverbSwitch.isOn
        )
    }
    

}

