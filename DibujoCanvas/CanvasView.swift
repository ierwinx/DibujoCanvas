import UIKit

class CanvasView: UIView {
    
    private var lines: Array<TouchPointAndColor> = []
    public var ancho: CGFloat = 1.0
    public var color: UIColor = .black
    public var opacity: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        lines.forEach { line in
            guard let puntosLinea = line.points else {
                return
            }
            for (i, p) in puntosLinea.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchPointAndColor(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else {
            return
        }
        guard var lastPoint = lines.popLast() else {
            return
        }
        lastPoint.points?.append(touch)
        lastPoint.color = self.color
        lastPoint.width = self.ancho
        lastPoint.opacity = self.opacity
        lines.append(lastPoint)
        setNeedsDisplay()
    }
    
    public func eliminarDibujo() -> Void {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    public func deshacer() -> Void {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
}
