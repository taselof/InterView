//
//  InstaCollectionViewCell.swift
//  InstaStory
//
//  Created by ozgen dindar on 21.07.2020.
//  Copyright © 2020 ozgen dindar. All rights reserved.
//

import UIKit
import AVKit

class InstaCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet private weak var playerView: PlayerView!
    
    func config(url: URL){
        self.playerView.player = AVPlayer(url: url)
    }
    
    func play(){
        self.playerView.player?.play()
    }
    
    func pause(){
        self.playerView.player?.pause()
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer){
        print(sender.state.rawValue)
        if sender.state == .began {
            print("pause")
            self.playerView.player?.pause()
        }else if sender.state == .ended{
            print("play")
            self.playerView.player?.play()
        }
        
    }
    
    @IBAction func tapping(_ sender: UITapGestureRecognizer) {
        print("tapping")
    }
    
}
