//: [Previous](@previous)
//#-hidden-code
import PlaygroundSupport
import SpriteKit
import UIKit

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: SceneSize.width.rawValue, height: SceneSize.height.rawValue))
if let yourAwesomeTshirt = CreationScene(fileNamed: "CreationScene") {
yourAwesomeTshirt.scaleMode = .aspectFit
// Sounds
let scissors = "scissors"
let lazer = "lazer"
let apple = "apple"
//#-end-hidden-code
/*:
 # Style your T-shirt
 
 **Breast**: The shop has standard sizes but to be 100% sure, please, make a simple measurement. Wrap the measuring tape somewhat loosely around the fullest part of your chest (at nipple level).
 Bust measurement is needed to sew a perfect T-shirt for you.
 */
yourAwesomeTshirt.breast = /*#-editable-code Bust mesurement*/0/*#-end-editable-code*/
//: Select the **color** of your T-shirt. If you won't make a choice, it will be white. Did you know that a white is a new black?
yourAwesomeTshirt.color = /*#-editable-code Color*/#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)/*#-end-editable-code*/
//: It's time to customise! Enter a **6-symbol word** instead of *WWDC19*. And your T-shirt will be truly unique. *If you enter more than 6 letters, the text will be cut, sorry.*
yourAwesomeTshirt.text = /*#-editable-code One cool word*/"WWDC19"/*#-end-editable-code*/
/*:
 # Special effects
 Let's imagine that it's a movie about making your T-shirt. We lack sound effects!
 To add a sound we need to create a new SKAction. The T-shirt will be hand-made but you can choose a laser sound to make it sound more hi-tech.
     **Hint**. Enter *scissors*, *lazer* or *apple*
 */
let playSound = SKAction.playSoundFileNamed(/*#-editable-code Sound*/scissors/*#-end-editable-code*/, waitForCompletion: true)
let repeatSound = SKAction.repeatForever(playSound)
yourAwesomeTshirt.soundAction = repeatSound

//#-hidden-code
sceneView.presentScene(yourAwesomeTshirt)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
//: [Next](@next)
