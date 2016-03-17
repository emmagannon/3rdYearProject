//
//  DrawLine.swift
//  Phase2
//
//  Created by Emma Gannon on 03/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//
// bottom of N: 339.0, 482.0

import Foundation
import UIKit

class DrawLine: UIView {

    var pointsToDraw:[Int] = []
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        
        let context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, self.bounds);
        CGContextSetLineWidth(context, 10.0);
        UIColor.blackColor().set()
        
        
        if pointsToDraw.count > 4 {
            
            CGContextMoveToPoint(context, CGFloat(pointsToDraw[0]), CGFloat(pointsToDraw[1]))
            
            for i in 2..<pointsToDraw.count {
                if i % 2 <= 0 {
                    CGContextAddLineToPoint(context, CGFloat(pointsToDraw[i]), CGFloat(pointsToDraw[i + 1]))
                }
            }
        }
        
        // Draw
        CGContextStrokePath(context);
    }


    
    /*var lines =  [CGPoint]()
    var drawImage: UIImage?
    let path = UIBezierPath()
    var shouldClear = false
    var view: UIView?
    var start = CGPoint()
    var end = CGPoint()
    var startMin = CGPoint(x: 335, y: 500)
    var startMax = CGPoint(x: 360, y: 510)
    var endMin = CGPoint(x: 440, y: 500)
    var endMax = CGPoint(x: 465, y: 510)
    
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
        
        start = position
        
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
        
        end = position1
        
    
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
        
        /*
        if((start.x > startMin.x && start.y > startMin.y) && (start.x < startMax.x && start.y < startMax.y))
        {
            print("correct start position")
        }
        */
        if((end.x > endMin.x && end.y > endMin.y) && (end.x < endMax.x && end.y < endMax.y))
        {
            print("correct end position")
        }

        
        /*
        if(((start.x > startMin.x && start.y > startMin.y) && (start.x < startMax.x && start.y < startMax.y)) && ((end.x > endMin.x && end.y > endMin.y) && (end.x < endMax.x && end.y < endMax.y)))
        {
            print("correct position")
        }
        */
    }*/
    
}
