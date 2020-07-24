//
//  PlayerView.swift
//  InstaStory
//
//  Created by ozgen dindar on 21.07.2020.
//  Copyright © 2020 ozgen dindar. All rights reserved.
//

import UIKit
import AVKit
class PlayerView: UIView{
    override static var layerClass: AnyClass{
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer{
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer?{
        get{
            return playerLayer.player
        }
        set{
            playerLayer.player = newValue
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = self.layer.bounds
        }
    }
}
