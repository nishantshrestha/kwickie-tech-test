//
//  KwickiePlayerController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 16/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import JGProgressHUD

class KwickiePlayerController: UIViewController {

    var kwickie: Kwickie?
    
    var kwickiePlayer: AVPlayer!
    
    @IBOutlet weak var kwickieInfoLabel: UILabel!
    @IBOutlet weak var playerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the navigation title
        navigationItem.title = "Kwickie"
        
        // Set up the Kwickie player
        if let kwickie = kwickie {
            // Set up the kwickieInfoLabel
            kwickieInfoLabel.attributedText = kwickie.kwickieUsersAttributedString()
            
            if let videoURLString = kwickie.kwickieVideo.processPlaylistURL {
                if let videoURL = URL(string: videoURLString) {
                    
                    // Set up the AVPlayer
                    kwickiePlayer = AVPlayer(url: videoURL)
                    
                    // Create AVPlayerViewController
                    let playerController = AVPlayerViewController()
                    
                    // Setup the playerController
                    playerController.player = kwickiePlayer
                    playerController.showsPlaybackControls = false
                    playerController.view.backgroundColor = UIColor("#F8F8F8")
                    playerController.videoGravity = AVLayerVideoGravityResizeAspect
                    
                    // Add player's view to the view hierarchy
                    playerView.addSubview(playerController.view)
                    
                    // Add constraints
                    playerView.addConstraintsWithFormat(format: "H:|[v0]|", views: playerController.view)
                    playerView.addConstraintsWithFormat(format: "V:|[v0]|", views: playerController.view)
                    
                    // Play the video
                    kwickiePlayer.play()
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        // Stop playing the video
        kwickiePlayer.pause()
        
        // Pop/dismiss view controller
        if let navCtrl = navigationController {
            navCtrl.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        // Debug deinit print.
        print("deinitialising vc")
    }
}

extension KwickiePlayerController {
    static func storyboardInstance() -> KwickiePlayerController? {
        let className = String(describing: self)
        
        let storyboard = UIStoryboard(name: className, bundle: nil)
        
        return storyboard.instantiateInitialViewController() as? KwickiePlayerController
        
    }
}
