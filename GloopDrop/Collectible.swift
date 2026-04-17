import Foundation
import SpriteKit
//This enum lets you add different types of collectibles
enum CollectibleType: String {
  case none
  case gloop
}


class Collectible: SKSpriteNode {
    // MARK: - PROPERTIES
    private var collectibleType: CollectibleType = .none
 
    // MARK: - INIT
    init(collectibleType: CollectibleType) {
        var texture: SKTexture!
        self.collectibleType = collectibleType
        
        // Set the texture based on the type
        switch self.collectibleType {
        case .gloop:
            texture = SKTexture(imageNamed: "gloop") // may need to be Gloop
        case .none:
            break
        }


        // Call to super.init
        super.init(texture: texture, color: SKColor.clear, size: texture.size())


        // Set up collectible
        self.name = "co_\(collectibleType)"
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.zPosition = Layer.collectible.rawValue
    }
    
    // Required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    func drop(dropSpeed: TimeInterval, floorLevel: CGFloat) {
        let pos = CGPoint(x: position.x, y: floorLevel) // end position
        
        // first shrink the drop down
        self.scale(to: CGSize(width: 0.25, height: 1.0))

        // then make the drop appear
        let appear = SKAction.fadeAlpha(to: 1.0, duration: 0.25)
        
        // make bigger
        let scaleX = SKAction.scaleX(to: 1.0, duration: 1.0)
        let scaleY = SKAction.scaleY(to: 1.3, duration: 1.0)
        let scale = SKAction.group([scaleX, scaleY]) // actions start as same time
        
        // drop it
        let moveAction = SKAction.move(to: pos, duration: dropSpeed)
        
        // the sequence of the animation
        let actionSequence = SKAction.sequence([appear, scale, moveAction])
        self.run(actionSequence, withKey: "drop")
    }

    
  
}

