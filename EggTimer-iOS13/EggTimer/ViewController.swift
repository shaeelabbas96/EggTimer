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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var totalTime = Int()
    let eggTimes = ["Soft" : 5*60 , "Medium" : 7*60 , "Hard" : 12*60 ]
    var seconds = 0
    var timer = Timer()
    var player: AVAudioPlayer?



     
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        seconds = 0
        titleLabel.text = hardness
        print(eggTimes[hardness]!)
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        //example functionality
        if seconds < totalTime {
            seconds += 1
            progressBar.progress = Float(Float(seconds)/Float(totalTime))
        } else{
            timer.invalidate()
            titleLabel.text = "DONE!"
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
            do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                    guard let player = player else { return }

                    player.play()

                } catch let error {
                    print(error.localizedDescription)
                }
        }
       
    }
    
}
