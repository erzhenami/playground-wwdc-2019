
import SpriteKit
import PlaygroundSupport
import UIKit

public class FinalScene: SKScene {
    
    public var action: SKAction?
    
    override public func didMove(to view: SKView) {
        if let gift = childNode(withName: "gift") {
            if let jump = action {
                gift.run(.repeatForever(jump))
            }
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
            if name == "downloadButton" || name == "buttonLabel" {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: pdfPath){
                    let document = NSData(contentsOfFile: pdfPath)
                    let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [document!], applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                    view!.window!.rootViewController!.present(activityViewController, animated: true, completion: nil)
                } else {
                    print("PDF file was not found:(")
                }
            }
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
