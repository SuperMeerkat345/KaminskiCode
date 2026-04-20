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
    
    var level: Int = 1               // the higher the level the faster the drop`
    var numberOfDrops: Int = 10      //
    
    var dropSpeed: CGFloat = 1.0
    var minDropSpeed: CGFloat = 0.12 // fastest drop allowed (no matter the level)
    var maxDropSpeed: CGFloat = 1.0  // slowest drop
    
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
        
        spawnMultipleGloops()
    }
    
    // MARK: - GAME FUNCTIONS
    
    func spawnMultipleGloops () {
        // set drop speed
        dropSpeed = 1 / (CGFloat(level) + CGFloat(level)/CGFloat(numberOfDrops)) // as level goes up, dropSpeed goes down so faster
        
        // bounds
        if dropSpeed < minDropSpeed {
            dropSpeed = minDropSpeed
        }
        else if dropSpeed > maxDropSpeed {
            dropSpeed = maxDropSpeed
        }
        
        // set up repeating action
        let wait = SKAction.wait(forDuration: TimeInterval(dropSpeed))
        let spawn = SKAction.run { [unowned self] in self.spawnGloop() }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeat(sequence, count: numberOfDrops)
        
        // run action
        run(repeatAction, withKey: "gloop")
    }
    
    func spawnGloop() {
        // create collectible
        let collectible = Collectible(collectibleType: .gloop) // CollectibleType.gloop vs .gloop??
        
        // set random position
        // this line makes sure the drop is completely visible
        let margin = collectible.size.width * 2 // how far away from border
        
        let dropRange = SKRange(
            lowerLimit: frame.minX + margin,
            upperLimit: frame.maxX - margin
        )
        let randomX = CGFloat.random(
            in: dropRange.lowerLimit...dropRange.upperLimit
        )
        collectible.position = CGPoint(x: randomX, y: player.position.y * 2.5)
        
        // add child to scene
        addChild(collectible)
        
        // run the spawning animation
        collectible.drop(dropSpeed: TimeInterval(1.0), floorLevel: player.frame.minY)
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

