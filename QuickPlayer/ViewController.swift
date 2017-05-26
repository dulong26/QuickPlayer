//
//  ViewController.swift
//  QuickPlayer
//
//  Created by Vu Thanh Tung on 5/26/17.
//  Copyright © 2017 silverpear. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    @IBOutlet weak var slDuration: UISlider!
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var swRepeat: UISwitch!
    var song = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        song = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        song.prepareToPlay()
        addThumbImgForSlider()
        song.delegate = self
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
        
    }
    //setup
    func addThumbImgForSlider() {
        slVolume.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        slVolume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
        slDuration.setThumbImage(UIImage(named: "duration.png"), for: .normal)
        lbTotalTime.text = String(format: "%2.2f", song.duration/60)
        if swRepeat.isOn {
            song.numberOfLoops = -1
        } else {
            song.numberOfLoops = 0
        }
    }
    
    func updateCurrentTime() {
        self.lbCurrentTime.text = String(format: "%2.2f", song.currentTime/60)
        self.slDuration.value = Float(song.currentTime/song.duration)
    }
    
    //action
    @IBAction func btPlayAction(_ sender: UIButton) {
        let icon = btPlay.image(for: .normal)
        if (icon == UIImage(named: "play.png")) {
            song.play()
            btPlay.setImage(UIImage(named: "pause.png"), for: .normal)
        } else {
            song.pause()
            btPlay.setImage(UIImage(named: "play.png"), for: .normal)
        }
    }
    
    @IBAction func slVolumeAction(_ sender: UISlider) {
        song.volume = sender.value
    }
    
    @IBAction func slDurationAction(_ sender: UISlider) {
        song.currentTime = TimeInterval(sender.value)*song.duration
    }
    
    @IBAction func swRepeatAction(_ sender: UISwitch) {
        if sender.isOn {
            song.numberOfLoops = -1
        } else {
            song.numberOfLoops = 0
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !swRepeat.isOn {
            btPlay.setImage(UIImage(named: "play.png"), for: .normal)
        }
    }
}

