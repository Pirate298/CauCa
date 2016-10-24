//
//  ViewController.swift
//  CauCa
//
//  Created by PIRATE on 9/28/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    var deepSea = AVAudioPlayer()
    var gameManager : GameManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSong()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(_:))))
//      Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
    }
    func tapHandle(_ sender: UIGestureRecognizer)
    {
        let tapPoint = sender.location(in: self.view)
        self.gameManager?.dropHookerAtX(Int(tapPoint.x))
        
    }
    
    
    
    @IBAction func act_reset(_ sender: AnyObject) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews
        {
            if (object .isKind(of: FishView.self))
            {
                object .removeFromSuperview()
            }
        }
        self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
    }
    
    @IBAction func act_addFish(_ sender: AnyObject) {
         self.gameManager?.addFishToviewController(self, width: Int(self.view.bounds.width))
    }
    func playSong()
    {
        let filePath = Bundle.main.path(forResource: "nhac song", ofType: ".mp3")
        let url = URL(fileURLWithPath: filePath!)
        deepSea = try! AVAudioPlayer(contentsOf: url)
        deepSea.prepareToPlay()
        deepSea.play()
    }

}

