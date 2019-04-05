//#-hidden-code
import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: SceneSize.width.rawValue, height: SceneSize.height.rawValue))
if let scene = FinalScene(fileNamed: "FinalScene") {
    scene.backgroundColor = UIColor.white
    scene.scaleMode = .aspectFit
//#-end-hidden-code
//:# Woohoo! Your T-shirt is ready:)
    
//: This is a little gift for you. Click the button to download your T-shirt.
//: Change x and y in moveBy method to get a wonderful effects. This gift box can more!
    
    let moveUp = SKAction.moveBy(x: /*#-editable-code*/0/*#-end-editable-code*/, y: /*#-editable-code*/20/*#-end-editable-code*/, duration: /*#-editable-code*/0.8/*#-end-editable-code*/)
    let moveDown = SKAction.moveBy(x: /*#-editable-code*/0/*#-end-editable-code*/, y: /*#-editable-code*/-20/*#-end-editable-code*/, duration: /*#-editable-code*/1/*#-end-editable-code*/)
    let jump = SKAction.sequence([moveUp, moveDown])

    //#-hidden-code
    scene.action = jump
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-hidden-code
//: [Next](@next)
