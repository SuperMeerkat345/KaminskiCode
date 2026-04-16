//
//  GameViewController.swift
//  GloopDrop
//
//  Created by Artiom Tkachenko on 4/6/26.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create the view
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: CGSize(width: 1336, height: 1024))
                
            // set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // set background color
            scene.backgroundColor = (
                UIColor(
                    red: 105/255,
                    green: 157/255,
                    blue: 181/255,
                    alpha: 1.0
                )
            )
            
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
