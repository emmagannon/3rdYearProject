//
//  WritingVCS.swift
//  LetterWritingCheck
//
//  Created by Emma Gannon on 11/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class WritingVCS: UIViewController {
    var rawPointsP:[Int] = []
    var recogniser:PathRecogniser?
    var score: Int? = 0

    //@IBOutlet weak var drawLineS: DrawLine!
    @IBOutlet weak var readyS: UIButton!
    @IBOutlet weak var renderView: RenderView!

    
    
    override func viewDidLoad() {
        
        
        if(sadAP.playing){
            sadAP.stop()
        }
        let recogniser = PathRecogniser(sliceCount: 8, deltaMove: 16.0)
        readyS.enabled = false
        readyS.hidden = true
        
        recogniser.addModel(PathModel(directions: [5,4,3,2,1,0,1,2,3,4,5], datas:"s"))
        
        self.recogniser = recogniser
        lessonAP.play()
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "sScore"){
            let destination = segue.destinationViewController as! ResultVC
            destination.score = score
            destination.letter = "s"
        }
    }
    
    func leftX(points: [Int]) -> Int{
        var counter:Int = 4
        let secondLeft:Int = points[(points.count - 2)]
        var left:Int = points[2]
        while(points.count > (counter + 2)){
            if(left > points[counter]){
                left = points[counter]
                if(left < points[counter + 2]){
                    break
                }
            }
            counter += 2
        }
        return(abs(left - secondLeft))
    }
    
    func rightX(points: [Int]) -> Int{
        let secondRight: Int = points[0]
        var counter:Int = 0
        var check: Bool = false
        var right:Int = points[2]
        while(points.count > (counter+2)){
            if(check == false && right > points[counter]){
                right = points[counter]
                check = true
            }
            else if(check == true && right < points[counter]){
                right = points[counter]
                if(points[counter+2] < right){
                    break
                }
            }
            counter += 2
        }
        return(abs(right - secondRight))
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        rawPointsP.removeAll()
        viewDidLoad()
        self.renderView.pointsToDraw = rawPointsP
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        rawPointsP = []
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPointsP.append(Int(location.x))
        rawPointsP.append(Int(location.y))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPointsP.append(Int(location.x))
        rawPointsP.append(Int(location.y))
        
        self.renderView.pointsToDraw = rawPointsP
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        var path:Path = Path()
        path.addPointFromRaw(rawPointsP)
        score = self.recogniser!.recognisePath(path)
        if(rawPointsP.count > 4){
            let right:Int = rightX(rawPointsP)
            let left:Int = leftX(rawPointsP)
            let diffR:Int = right/20
            let diffL:Int = left/20
            score = score! + diffR + diffL
        }
        readyS.hidden = false
        readyS.enabled = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    


}
