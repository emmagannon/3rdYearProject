//
//  WritingVC.swift
//  Phase2
//
//  Created by Emma Gannon on 15/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class WritingVC: UIViewController {
    
    var rawPoints:[Int] = []
    var recogniser:PathRecogniser?

    @IBOutlet weak var Answer: UILabel!
    @IBOutlet var drawLine: DrawLine!
    
    enum FilterOperation {
        case Maximum
        case Minimum
    }
    
    enum FilterField {
        case LastPointX
        case LastPointY
    }

    override func viewDidLoad() {
        
        let recogniser = PathRecogniser(sliceCount: 8, deltaMove: 16.0)
        
        let maxy3 = WritingVC.customFilter(self)(.Maximum, .LastPointY, 0.3)
        let miny3 = WritingVC.customFilter(self)(.Minimum, .LastPointY, 0.3)
        let maxy7 = WritingVC.customFilter(self)(.Maximum, .LastPointY, 0.7)
        let miny7 = WritingVC.customFilter(self)(.Minimum, .LastPointY, 0.7)
        
        
        recogniser.addModel(PathModel(directions: [7, 1], datas:"A"))
        recogniser.addModel(PathModel(directions: [2,6,0,1,2,3,4,0,1,2,3,4], datas:"B"))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0], datas:"C"))
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"D", filter:miny7))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0,4,3,2,1,0], datas:"E"))
        recogniser.addModel(PathModel(directions: [4,2], datas:"F"))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,0], datas:"G", filter:miny3))
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2], datas:"H"))
        recogniser.addModel(PathModel(directions: [2], datas:"I"))
        recogniser.addModel(PathModel(directions: [2,3,4], datas:"J"))
        recogniser.addModel(PathModel(directions: [3,4,5,6,7,0,1], datas:"K"))
        recogniser.addModel(PathModel(directions: [2,0], datas:"L"))
        recogniser.addModel(PathModel(directions: [6,1,7,2], datas:"M"))
        recogniser.addModel(PathModel(directions: [6,1,6], datas:"N"))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4], datas:"O", filter:maxy3))
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"P", filter:maxy7))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4,0], datas:"Q", filter: maxy3))
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2,3,4,1], datas:"R"))
        recogniser.addModel(PathModel(directions: [4,3,2,1,0,1,2,3,4], datas:"S"))
        recogniser.addModel(PathModel(directions: [0,2], datas:"T"))
        recogniser.addModel(PathModel(directions: [2,1,0,7,6], datas:"U"))
        recogniser.addModel(PathModel(directions: [1,7,0], datas:"V"))
        recogniser.addModel(PathModel(directions: [2,7,1,6], datas:"W"))
        recogniser.addModel(PathModel(directions: [1,0,7,6,5,4,3], datas:"X"))
        recogniser.addModel(PathModel(directions: [2,1,0,7,6,2,3,4,5,6,7], datas:"Y"))
        recogniser.addModel(PathModel(directions: [0,3,0], datas:"Z"))
        
        //recogniser.addModel(PathModel(directions: [7, 1], datas:"A"))
        //recogniser.addModel(PathModel(directions: [6,1,6], datas:"N"))
        //recogniser.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"P", filter:maxy7))
        //recogniser.addModel(PathModel(directions: [4,3,2,1,0,1,2,3,4], datas:"S"))
        
        self.recogniser = recogniser
        
        super.viewDidLoad()
        
    }

    func minLastY(cost:Int, infos:PathInfos, minValue:Double)->Int
    {
        let py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py < minValue ? Int.max : cost
    }
    
    func maxLastY(cost:Int, infos:PathInfos, maxValue:Double)->Int
    {
        let py:Double = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        return py > maxValue ? Int.max : cost
    }
    
    func customFilter(operation:FilterOperation,_ field:FilterField, _ value:Double)(cost:Int, infos:PathInfos)->Int
    {
        
        var pvalue:Double
        
        switch field
        {
        case .LastPointY:
            pvalue = (Double(infos.deltaPoints.last!.y) - Double(infos.boundingBox.top)) / Double(infos.height)
        case .LastPointX:
            pvalue = (Double(infos.deltaPoints.last!.x) - Double(infos.boundingBox.left)) / Double(infos.width)
        }
        
        switch operation
        {
            case .Maximum:
                return pvalue > value ? Int.max : cost
            case .Minimum:
                return pvalue < value ? Int.max : cost
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        rawPoints = []
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
        
        self.drawLine.pointsToDraw = rawPoints
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        
        var path:Path = Path()
        path.addPointFromRaw(rawPoints)
        
        let gesture:PathModel? = self.recogniser!.recognisePath(path)
        
        if gesture != nil
        {
            Answer.text = gesture!.datas as? String
        }
        else
        {
            Answer.text = "Incorrect"
        }
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}
