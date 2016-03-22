//
//  DrawLine.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 03/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import Foundation
import UIKit

class DrawLine: UIView {

    var pointsToDraw:[Int] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
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
                if i % 2 == 0 {
                    CGContextAddLineToPoint(context, CGFloat(pointsToDraw[i]), CGFloat(pointsToDraw[i + 1]))
                }
            }
        }
        
        // Draw
        CGContextStrokePath(context);
    }
}
