//
//  DetailViewController.swift
//  Current Weather
//
//  Created by Makzan on 23/12/2020.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    var weather:Weather = Weather()
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var tomorrowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        todayLabel.text = weather.todayDescription
        tomorrowLabel.text = weather.tomorrowDescription
    }
    
    @IBAction func speakDescription(_ sender: Any) {
        // https://developer.apple.com/documentation/avfoundation/speech_synthesis
        let utterance = AVSpeechUtterance(string: weather.todayDescription)
        
        // Configure the utterance.
//        utterance.rate = 0.57
//        utterance.pitchMultiplier = 0.8
//        utterance.postUtteranceDelay = 0.2
//        utterance.volume = 0.8
        
        // Retrieve the British English voice.
        let voice = AVSpeechSynthesisVoice(language: "zh-HK")

        // Assign the voice to the utterance.
        utterance.voice = voice
        
        // Create a speech synthesizer.
        let synthesizer = AVSpeechSynthesizer()

        // Tell the synthesizer to speak the utterance.
        synthesizer.speak(utterance)
    }
    
    

}
