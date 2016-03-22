//
//  WritingVCP.swift
//  LetterWritingCheck
//
//  Created by Emma Gannon on 11/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit
import AVFoundation

class WritingVCP: UIViewController {
    var rawPointsP:[Int] = []
    var recogniser:PathRecogniser?
    var score: Int? = 0

    @IBOutlet weak var drawLineP: DrawLine!
    @IBOutlet weak var readyP: UIButton!
    
    
    override func viewDidLoad() {
        
        
        if(sadAP.playing){
            sadAP.stop()
        }
        let recogniser = PathRecogniser(sliceCount: 8, deltaMove: 16.0)
        readyP.enabled = false
        readyP.hidden = true
        
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2,3,4,5], datas:"p"))
        
        self.recogniser = recogniser
        MenuAudioPlayer.play()
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pScore"){
            let destination = segue.destinationViewController as! ResultVC
            destination.score = score
            destination.letter = "p"
        }
    }
    
    
    
    func lowY(points: [Int]) ->Int{
        var counter: Int = 3
        var lowest: Int = points[1]
        while (points.count > (counter + 1)){
            if(points[counter] > lowest){
                lowest = points[counter]
            }
            if(points[counter + 2] < lowest){
                break
            }
            counter += 2
        }
        let midpoint = (points[1] + lowest) / 2
        return (abs(midpoint - points.last!))
    }
    
    func highY(points: [Int])->Int {
        var counter: Int = 3
        var highest: Int = 0
        var temp: Int = 0
        let secondHighest: Int = points[1]
        while (points.count > (counter + 1)){
            if(temp == 0 && (points[counter] > points[counter+2])){
                temp = points[counter]
                highest = points[counter+2]
            }
            if(temp != 0 && highest > points[counter]){
                highest = points[counter]
            }
            counter += 2
        }
        return (abs(highest - secondHighest))
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        rawPointsP.removeAll()
        viewDidLoad()
        self.drawLineP.pointsToDraw = rawPointsP
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
        
        self.drawLineP.pointsToDraw = rawPointsP
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        var path:Path = Path()
        path.addPointFromRaw(rawPointsP)
        score = self.recogniser!.recognisePath(path)
        if(rawPointsP.count > 4){
            let low:Int = lowY(rawPointsP)
            let high:Int = highY(rawPointsP)
            let diffL:Int = low/20
            let diffH:Int = high/20
            score = score! + diffL + diffH
        }
        readyP.hidden = false
        readyP.enabled = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
