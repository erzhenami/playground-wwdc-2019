import Foundation
import PlaygroundSupport

public enum SceneSize: Int {
    case width = 800
    case height = 600
}

// Directory for saving PDF file
let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

public let pdfPath = (documentsDirectory as NSString).appendingPathComponent("tshirt.jpg") as String

public enum Sizes: String {
    case xxxs = "XXXS"
    case xxs = "XXS"
    case xs = "XS"
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
    case xxl = "XXL"
    case xxxl = "XXXL"
    case xxxxl = "XXXXL"
    case xxxxxl = "XXXXXL"
    case xxxxxxl = "XXXXXXL"
    case notFound = "?"
}
