//
//  GameScene.swift
//  GloopDrop
//
//  Created by Artiom Tkachenko on 4/6/26.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // GameScene Variables
    let player = Player()
    let playerSpeed: CGFloat = 1.5
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background_1")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.background.rawValue
        
        background.position = CGPoint(x: 0, y: 0)
        addChild(background)
        
        let foreground = SKSpriteNode(imageNamed: "foreground_1")
        foreground.anchorPoint = CGPoint(x: 0, y: 0)
        foreground.zPosition = Layer.foreground.rawValue
        
        foreground.position = CGPoint(x: 0, y: 0)
        addChild(foreground)
        
        // add player
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        addChild(player)
        player.walk()
    }
    
    // MARK: - TOUCH HANDLING
          
          /* ############################################################ */
          /*                 TOUCH HANDLERS STARTS HERE                   */
          /* ############################################################ */
          
    func touchDown(atPoint pos: CGPoint) {
        // calculate the speed based on the current position and tap location
        let distance = hypot(pos.x - player.position.x, pos.y - player.position.y)
        //let distance = pos.x-player.position.x
        let calculatedSpeed = TimeInterval(distance/playerSpeed) / 255
        
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos, direction: "L", speed: calculatedSpeed)
        }
        else {
            player.moveToPosition(pos: pos, direction: "R", speed: calculatedSpeed)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }


}

