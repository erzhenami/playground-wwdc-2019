//#-hidden-code
import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: SceneSize.width.rawValue, height: SceneSize.height.rawValue))
if let scene = IntroScene(fileNamed: "IntroScene") {
    scene.scaleMode = .aspectFit
//#-end-hidden-code
/*:
# Welcome to the Sprite Shop!
    
In this shop a customer is a king. So you can literally customise everything you want. In this playground book you will be free to change animation with SpriteKit actions.
     
Let's start! Press **Run my code** to see the shop's main page.
     
---
     
## 1. The button Start shopping

Oh, no! It's pulsing. Does it annoy you? Or don't you want to make the button blink? You decide!
---
* Change *by* parameter to 1.0 to stop a button scaling. Or change to 0.0 to make it disappear.🎩 Is the font too small? Let's make the button bigger by setting *by* to *2.0*.
* **Hint**. If you want the button change the size faster, set *duration* parameter to 0.5.
---
*/
    let scaleDown = SKAction.scale(by: /*#-editable-code*/0.95/*#-end-editable-code*/, duration: /*#-editable-code*/1/*#-end-editable-code*/)
//: Then we create an action that magically returns everything to its place.
    let scaleUp = scaleDown.reversed()
//: Mix 2 actions in a sequence to have an amazing effect: the button becomes smaller and after that returns to its normal size.
    let scaleDownUp = SKAction.sequence([scaleDown, scaleUp])
/*:
If you are done, please, press the **Run my code** button. Enjoy your custom animation!


## 2. A special offer

I suspect that you already tried to press the button *Start shopping*. If not, try it now.
You are lucky! I have a special offer for you. If you create one t-shirt, you will get as many as you wish. Just type in the number here. Run the code to see your offer!
*/
    let magicNumber = /*#-editable-code How many t-shirts do you want?*/0/*#-end-editable-code*/
//#-hidden-code
    scene.buttonAction = scaleDownUp
    scene.numberOfTShirts = magicNumber
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
//: [Next](@next)
