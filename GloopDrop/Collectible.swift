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
  
}

