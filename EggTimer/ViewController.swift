//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsTotal : Float = 0
    var secondsPassed : Float = 0
    var timer = Timer()
    
    
    @IBOutlet weak var eggsLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        secondsTotal = Float(eggTimes[hardness]!)
        progressView.progress = 0.0
        secondsPassed = 0
        eggsLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed < secondsTotal {
            secondsPassed += 1
            progressView.progress = secondsPassed / secondsTotal
            print(progressView.progress)
            
        } else {
            timer.invalidate()
            eggsLabel.text = "Done"
            playSound(fileName: "alarm_sound", fileExtension: "mp3")
            
        }
    }
    
    func playSound(fileName : String, fileExtension : String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
