//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Anderson Konzen on 3/11/15.
//  Copyright (c) 2015 Anderson Konzen. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var file: AVAudioFile!
    @IBOutlet weak var reverbSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        
        file = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        playSound(0.5, pitch: 1.0)
    }

    @IBAction func playSoundFast(sender: UIButton) {
        playSound(1.5, pitch: 1.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playSound(1.0, pitch: 1200)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playSound(1.0, pitch: -1000)
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        resetAudioPlayer()
    }
    
    func resetAudioPlayer() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playSound(rate: Float, pitch: Float) {
        resetAudioPlayer()
        
        var player = AVAudioPlayerNode()
        
        var pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        pitchEffect.rate = rate
        
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.wetDryMix = reverbSlider.value
        
        // Add nodes to engine
        audioEngine.attachNode(player)
        audioEngine.attachNode(pitchEffect)
        audioEngine.attachNode(reverbEffect)
        
        // Connect the nodes
        audioEngine.connect(player, to: pitchEffect, format: file.processingFormat)
        audioEngine.connect(pitchEffect, to: reverbEffect, format: file.processingFormat)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: file.processingFormat)
        
        player.scheduleFile(file, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        player.play()
    }
}
