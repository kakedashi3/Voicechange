//
//  ViewController.swift
//  Voicechange
//
//  Created by 立岡力 on 2021/09/01.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
        
    var audio = Audio()
    
    
    @IBOutlet weak var speedSlider: UISlider! {
        didSet {
            speedSlider.minimumValue = 0.5
            speedSlider.minimumValue = 1.5
            speedSlider.setValue(1, animated: true)
            speedSlider.tintColor = .blue
        }
    }
    
    @IBOutlet weak var pictchSlider: UISlider! {
        didSet {
            pictchSlider.minimumValue = -1000
            pictchSlider.minimumValue = 1000
            pictchSlider.setValue(0, animated: true)
            pictchSlider.tintColor = .blue
        }
    }
    
    
    @IBOutlet weak var echoSwitch: UISwitch! {
        didSet {
            echoSwitch.isOn = false
            echoSwitch.onTintColor = .blue
            echoSwitch.tintColor = .blue
        }
    }
    
    
    @IBOutlet weak var reverbSwitch: UISwitch! {
        didSet {
            reverbSwitch.isOn = false
            reverbSwitch.onTintColor = .blue
            reverbSwitch.tintColor = .blue
        }
    }
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
    }

    
    
    @IBAction func record(_ sender: Any) {
    }
    
    
    @IBAction func play(_ sender: Any) {
    }
    

}

