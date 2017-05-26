//
//  ViewController.swift
//  QuickPlayer
//
//  Created by Vu Thanh Tung on 5/26/17.
//  Copyright © 2017 silverpear. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    var song = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        song = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        song.prepareToPlay()
        addThumbImgForSlider()
        
    }
    //setup
    func addThumbImgForSlider() {
        slVolume.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        slVolume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
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

}

