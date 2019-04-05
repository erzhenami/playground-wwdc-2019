
import PlaygroundSupport
import SpriteKit
import CoreGraphics
import Foundation

public class CreationScene: SKScene {
    
    public var breast: Int?
    public var color: UIColor?
    public var text: String?
    public var soundAction: SKAction?
    
    private var hasAllInfo = false
    
    private var titleLabel: SKLabelNode!
    private var divider: SKShapeNode!
    private var topBreastLabel: SKLabelNode!
    private var colorLabel: SKLabelNode!
    private var breastLabel: SKLabelNode!
    private var colorBox: SKShapeNode!
    private var button: SKShapeNode!
    private var scissors: SKSpriteNode!
    private var shapeNode: SKShapeNode!
    private var fabric: SKShapeNode!
    private var textLabel: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        
        initializeNodes()
        
        if let breast = breast, let color = color, let text = text {
            breastLabel.text = getSize(breast: breast).rawValue
            colorBox.fillColor = color
            // Add a custom text
            textLabel.text = String(text.prefix(6))
            textLabel.fontColor = getComplementaryForColor(color)
            
            if breast > 0 {
                button.fillColor = UIColor.red
                hasAllInfo = true
            } else {
                button.fillColor = UIColor.gray
                hasAllInfo = false
            }
        }
    }
    
    func initializeNodes() {
        titleLabel = childNode(withName: "//title") as? SKLabelNode
        divider = childNode(withName: "//divider") as? SKShapeNode
        topBreastLabel = childNode(withName: "//bust") as? SKLabelNode
        colorLabel = childNode(withName: "//color") as? SKLabelNode
        breastLabel = childNode(withName: "//bustLabel") as? SKLabelNode
        colorBox = childNode(withName: "//colorBox") as? SKShapeNode
        textLabel = childNode(withName: "//textLabel") as? SKLabelNode
        button = childNode(withName: "//sewButton") as? SKShapeNode
    }
    
    func getSize(breast: Int) -> Sizes {
        switch breast {
        case 78...81:
            return .xxxs
        case 82...85:
            return .xxs
        case 86...89:
            return .xs
        case 90...93:
            return .s
        case 94...97:
            return .m
        case 98...101:
            return .l
        case 102...105:
            return .xl
        case 106...109:
            return .xxl
        case 110...113:
            return .xxxl
        case 114...117:
            return .xxxxl
        case 118...121:
            return .xxxxxl
        case 122...125:
            return .xxxxxxl
        default:
            return .notFound
        }
    }
    
    // Function origin: https://gist.github.com/klein-artur/025a0fa4f167a648d9ea
    func getComplementaryForColor(_ color: UIColor) -> UIColor {
        
        let ciColor = CIColor(color: color)
        
        // get the current values and make the difference from white:
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
    }
    
    @objc override public static var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !hasAllInfo {
            return
        }
        
        if getSize(breast: breast!) == .notFound {
            return
        }
        
        let touch = touches.first! as UITouch
        let position = touch.location(in: self)
        let touchedNode = self.atPoint(position)
        
        if let name = touchedNode.name {
            if name == "sewButton" || name == "sewLabel" {
                
                titleLabel.text = "Sewing your T-shirt:)"
                removeChildren(in: [topBreastLabel, colorLabel, breastLabel, colorBox, button, divider])
                
                addFabric()
                addScissors()
                
                let path = cut()
                
                // Add a t-shirt node
                let tShirtNode = SKShapeNode(path: path.cgPath)
                if let color = color {
                    tShirtNode.fillColor = color
                }
                tShirtNode.zPosition = -1
                addChild(tShirtNode)
                
                tShirtNode.run(.wait(forDuration: 26, withRange: 26), completion: {
                    
                    tShirtNode.zPosition = 2
                    let moveToCenter = SKAction.move(to: CGPoint(x: tShirtNode.frame.midX, y: self.view!.frame.midY - 150), duration: 1)
                    tShirtNode.run(moveToCenter)
                    
                    self.removeChildren(in: [self.scissors, self.shapeNode, self.fabric])
                    
                    // Show a T-shirt text
                    self.textLabel.position = CGPoint(x: tShirtNode.frame.midX, y: tShirtNode.frame.midY + 130)
                    self.textLabel.run(.fadeIn(withDuration: 1))
                    
                    self.titleLabel.text = "Amazing T-shirt!"
                    
                    // Show stars
                    let leftStar = self.childNode(withName: "leftStar")
                    let rightStar = self.childNode(withName: "rightStar")
                    
                    leftStar?.alpha = 1.0
                    rightStar?.alpha = 1.0
                    
                    let rotate = SKAction.rotate(byAngle: CGFloat(Float.pi / 6), duration: 0.3)
                    leftStar?.run(.repeatForever(rotate))
                    rightStar?.run(.repeatForever(rotate.reversed()))
                    
                    // Play a sound
                    let fanfare = SKAction.playSoundFileNamed("success", waitForCompletion: true)
                    tShirtNode.run(fanfare)
                    
                    // Create an image to share
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.createImage()
                    }
                    
                })
                
            }
        }
    }
    
    func addFabric() {
        fabric = SKShapeNode(rect: CGRect(x: -400, y: -300, width: 800, height: 500))
        fabric.fillColor = UIColor.white
        fabric.zPosition = 0
        addChild(fabric)
    }
    
    func addScissors() {
        scissors = SKSpriteNode(imageNamed: "hand-scissors")
        scissors.zPosition = 1
        addChild(scissors)
    }
    
    func cut() -> UIBezierPath {
        // T-shirt measurements
        let bustCut = CGFloat(breast! * 2)
        let sleeveLength = CGFloat(80.0)
        let sleeveHeight = CGFloat(80.0)
        let tshirtLength = CGFloat(200.0)
        
        // Drawing points
        let bottomLeftPoint = CGPoint(x: fabric.frame.midX +  100 - bustCut, y: fabric.frame.minY)
        let middleLeftPoint = CGPoint(x: bottomLeftPoint.x, y: fabric.frame.minY + tshirtLength)
        
        let leftSleevePointX = bottomLeftPoint.x - sleeveLength
        let rightSleevePointX = leftSleevePointX + sleeveLength * 2 + bustCut
        
        let middleLeftPointSleeve = CGPoint(x: leftSleevePointX, y: bottomLeftPoint.y + tshirtLength)
        let topLeftPointSleeve = CGPoint(x: leftSleevePointX, y: bottomLeftPoint.y + tshirtLength + sleeveHeight)
        let leftNecklinePoint = CGPoint(x: leftSleevePointX + ((rightSleevePointX - leftSleevePointX) / 4), y: bottomLeftPoint.y + tshirtLength + sleeveHeight)
        
        // Control points for neckline
        let necklineControlPoint1 = CGPoint(x: leftSleevePointX + ((rightSleevePointX - leftSleevePointX) / 2), y: bottomLeftPoint.y + 190.0)
        let necklineControlPoint2 = CGPoint(x: rightSleevePointX - ((rightSleevePointX - leftSleevePointX) / 2), y: bottomLeftPoint.y + 190.0)
        
        // Right side points
        let rightNecklinePoint = CGPoint(x: rightSleevePointX - ((rightSleevePointX - leftSleevePointX) / 4), y: bottomLeftPoint.y + tshirtLength + sleeveHeight)
        let topRightPointSleeve = CGPoint(x: rightSleevePointX, y: bottomLeftPoint.y + tshirtLength + sleeveHeight)
        let middleRightPointSleeve = CGPoint(x: rightSleevePointX, y: bottomLeftPoint.y + tshirtLength)
        let middleRightPoint = CGPoint(x: leftSleevePointX + bustCut + sleeveLength, y: fabric.frame.minY + tshirtLength)
        let bottomRightPoint = CGPoint(x: leftSleevePointX + bustCut + sleeveLength, y: fabric.frame.minY)
        
        scissors.position = bottomLeftPoint
        
        // Cut the whole T-shirt
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bottomLeftPoint.x, y: fabric.frame.minY))
        path.addLine(to: middleLeftPoint)
        path.addLine(to: middleLeftPointSleeve)
        path.addLine(to: topLeftPointSleeve)
        path.addLine(to: leftNecklinePoint)
        path.addCurve(to: rightNecklinePoint,
                      controlPoint1: necklineControlPoint1,
                      controlPoint2: necklineControlPoint2)
        path.addLine(to: topRightPointSleeve)
        path.addLine(to: middleRightPointSleeve)
        path.addLine(to: middleRightPoint)
        path.addLine(to: bottomRightPoint)
        path.addLine(to: bottomLeftPoint)
        path.close()
        
        let move = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 100)
        if let sound = soundAction {
            scissors.run(.group([move, sound]))
        } else {
            scissors.run(move)
        }
        
        let pattern: [CGFloat] = [20.0, 20.0]
        shapeNode = SKShapeNode(path: path.cgPath.copy(dashingWithPhase: 2, lengths: pattern))
        shapeNode.strokeColor = UIColor.black
        addChild(shapeNode)
        
        return path
    }
    
    func createImage() {
      
        let bounds = self.scene!.view?.bounds
        UIGraphicsBeginImageContextWithOptions(bounds!.size, true, UIScreen.main.scale)
        self.scene?.view!.drawHierarchy(in: bounds!, afterScreenUpdates: true)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        let data = image.jpegData(compressionQuality: 1.0)
        do { try data?.write(to: URL(fileURLWithPath: pdfPath)) }
        catch {
        
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
