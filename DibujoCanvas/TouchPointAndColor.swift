import UIKit

struct TouchPointAndColor {
    
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
    
}
