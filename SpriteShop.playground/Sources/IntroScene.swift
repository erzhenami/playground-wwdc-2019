
import SpriteKit
import CoreGraphics

public class IntroScene: SKScene {
    
    // SpriteKit nodes
    private var background: SKSpriteNode!
    private var darkLayer: SKSpriteNode!
    private var label: SKLabelNode!
    private var button: SKNode!
    private var line: SKShapeNode!
    
    // Actions constants
    let scaleUp = SKAction.scale(by: 1.2, duration: 0.3)
    let scaleDown = SKAction.scale(by: 0.8, duration: 0.3)
    let scaleXToZero = SKAction.scaleX(to: 0, duration: 0.5)
    let scaleUpTwice = SKAction.scale(by: 2.0, duration: 0.5)
    
    let fadeOut = SKAction.fadeOut(withDuration: 0.5)
    let fadeIn = SKAction.fadeIn(withDuration: 1.0)
    let fadeInFast = SKAction.fadeIn(withDuration: 0.5)
    
    // Public variables
    public var buttonAction: SKAction?
    public var numberOfTShirts: Int?
    
    override public func didMove(to view: SKView) {
        
        // Background image
        background = SKSpriteNode(imageNamed: "shop")
        background.size = CGSize(width: Int(view.frame.width), height: Int(view.frame.height))
        background.position = CGPoint.zero
        background.zPosition = -1
        addChild(background)
        
        // Overlay mask
        darkLayer =
            SKSpriteNode(color: UIColor.black, size: view.frame.size)
        darkLayer.size = CGSize(width: Int(view.frame.width), height: Int(view.frame.height))
        darkLayer.alpha = 0.5
        darkLayer.zPosition = 0
        addChild(darkLayer)
        
        // Shop label
        label = childNode(withName: "//gameName") as? SKLabelNode
        label.alpha = 0.0
        label.run(fadeIn)
        
        // Underline line
        line = childNode(withName: "//divider") as? SKShapeNode
        
        // Button
        button = childNode(withName: "//goToShopButton") as? SKShapeNode
        if let buttonAction = buttonAction {
            button.run(.repeatForever(buttonAction))
        }
    }
    
    @objc override public static var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        let position = touch.location(in: self)
        let touchedNode = self.atPoint(position)
        
        if let name = touchedNode.name {
            if name == "goToShopButton" || name == "buttonLabel" {
                removeButton()
                removeShopTitle()
                removeLine()
                removeBackground()
                addCoolQuote()
                if let numberOfTShirts = numberOfTShirts {
                    if numberOfTShirts > 0 { showOffer() }
                }
            }
        }
    }
    
    func removeButton() {
        let moveRight = SKAction.move(to: CGPoint(x: self.frame.width + button.frame.width, y: button.frame.minY), duration: 0.3)
        let animateButton = SKAction.sequence([scaleUp, scaleDown, moveRight])
        button.run(animateButton)
    }
    
    func removeShopTitle() {
        label.run(fadeOut)
    }
    
    func removeLine() {
        line.run(scaleXToZero)
    }
    
    func removeBackground() {
        background.run(scaleUpTwice)
        background.run(fadeOut)
        darkLayer.run(fadeOut)
    }
    
    func addCoolQuote() {
        // Add words
        let word1 = addLabelNode(withText: "Design", position: CGPoint(x: self.frame.midX - 600, y: (self.frame.maxY / 3) * 2 - 120.0))
        addChild(word1)
        
        let word2 = addLabelNode(withText: "Your", position: CGPoint(x: self.frame.midX - 600, y: 40.0))
        addChild(word2)
        
        let word3 = addLabelNode(withText: "T-shirt", position: CGPoint(x: self.frame.midX - 600, y: (self.frame.maxY / 3) - 190.0))
        addChild(word3)
        
        // Animate words
        let wait1 = SKAction.wait(forDuration: 2, withRange: 2)
        let moveRight1 = SKAction.moveTo(x: self.frame.midX - 100, duration: 0.3)
        word1.run(.sequence([wait1, fadeInFast, moveRight1]))
        
        let wait2 = SKAction.wait(forDuration: 3, withRange: 3)
        let moveRight2 = SKAction.moveTo(x: self.frame.midX - 100, duration: 0.3)
        word2.run(.sequence([wait2, fadeInFast, moveRight2]))
        
        let wait3 = SKAction.wait(forDuration: 2, withRange: 2)
        let moveRight3 = SKAction.moveTo(x: self.frame.midX - 100, duration: 0.3)
        word3.run(.sequence([wait3, fadeInFast, moveRight3]))
    }
    
    func addLabelNode(withText text: String, position: CGPoint) -> SKLabelNode {
        let label = SKLabelNode(text: text)
        label.fontColor = UIColor.white
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 120.0
        label.horizontalAlignmentMode = .left
        label.alpha = 0.0
        label.zPosition = 1
        label.position = position
        return label
    }
    
    func showOffer() {
        let offer = addLabelNode(withText: "Create 1 T-shirt and get \(numberOfTShirts!)!😃", position: CGPoint(x: self.frame.midX - 300, y: -250))
        offer.fontSize = 40.0
        addChild(offer)
        let wait = SKAction.wait(forDuration: 3, withRange: 3)
        offer.run(.sequence([wait, fadeInFast]))
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
