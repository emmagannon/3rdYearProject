//
//  DrawLine.swift
//  Phase2
//
//  Created by Emma Gannon on 03/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//
// bottom of N: 339.0, 482.0

import UIKit
import SpriteKit

class DrawLine: UIView {

    
    var lines =  [CGPoint]()
    var drawImage: UIImage?
    let path = UIBezierPath()
    var shouldClear = false
    var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .whiteColor()
        
        path.lineCapStyle = .Round
        path.lineJoinStyle = .Round
        path.lineWidth = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        lines.append(touch.locationInView(self))
        let position = touch.locationInView(view)
        print(position)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        for coalescedTouch in event!.coalescedTouchesForTouch(touch)! {
            lines.append(coalescedTouch.locationInView(self))
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        
        drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        lines.removeAll()
        
        let touch = touches.first!
        let position1 = touch.locationInView(view)
        print(position1)
    }
    
    func getMidpointFromPointA(a: CGPoint, andB b: CGPoint) ->  CGPoint {
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }

    override func drawRect(rect: CGRect) {
        // Drawing code
        guard shouldClear != true else{
            UIColor.whiteColor().setFill()
            UIRectFill(rect)
            shouldClear = false
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetShouldAntialias(context, true)
        
        UIColor.blackColor().setStroke()
        
        path.removeAllPoints()
        
        drawImage?.drawInRect(rect)
        
        if !lines.isEmpty {
            path.moveToPoint(lines.first!)
            path.addLineToPoint(getMidpointFromPointA(lines.first!, andB: lines[1]))
            
            for index in 1..<lines.count - 1 {
                let midpoint = getMidpointFromPointA(lines[index], andB: lines[index-1])
                
                path.addQuadCurveToPoint(midpoint, controlPoint: lines[index])
            }
            
            path.addLineToPoint(lines.last!)
            
            path.stroke()
        }
           }
    


}
