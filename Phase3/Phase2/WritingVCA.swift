//
//  WritingVCA.swift
//  LetterWritingCheck
//
//  Created by Emma Gannon on 11/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit
import AVFoundation

class WritingVCA: UIViewController {
    
    var rawPointsP:[Int] = []
    var recogniser:PathRecogniser?
    var score: Int? = 0

    //@IBOutlet weak var drawLineA: DrawLine!
    @IBOutlet weak var renderView: RenderView!
    @IBOutlet weak var readyA: UIButton!
    
    
    override func viewDidLoad() {
        
        
        if(sadAP.playing){
            sadAP.stop()
        }
        let recogniser = PathRecogniser(sliceCount: 8, deltaMove: 16.0)
        readyA.enabled = false
        readyA.hidden = true
        
        recogniser.addModel(PathModel(directions: [5,4,3,2,1,0,7,6,2], datas:"a"))
        
        self.recogniser = recogniser
        if(MenuAudioPlayer.playing){
            MenuAudioPlayer.stop()
        }
        lessonAP.play()
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "aScore"){
            let destination = segue.destinationViewController as! ResultVC
            destination.score = score
            destination.letter = "a"
        }
    }
    
    
    
    func lowY(points: [Int]) ->Int{
        var counter: Int = 3
        var lowest: Int = points[1]
        while (counter < points.count){
            if(points[counter] > lowest){
                lowest = points[counter]
            }
            if(lowest != points[1] && points.count > (counter + 1)){
                if(points[counter + 2] < lowest){
                    break
                }
            }
            counter += 2
        }
        return (abs(lowest - points.last!))
    }
    
    func highY(points: [Int])->Int {
        var counter: Int = 3
        var highest: Int = 0
        var check: Bool = false
        var secondHighest: Int = points[1]
        while (counter < points.count){
            if(points.count > (counter + 2)){
                if(check == false && (points[counter] < points[counter+2])){
                    secondHighest = points[counter]
                    check = true
                }
                if(check == true && points[counter + 2] < points[counter]){
                    highest = points[counter + 2]
                    if(points[counter + 2] > points[counter]){
                        break
                    }
                }
            }
            counter += 2
        }
        return (abs(highest - secondHighest))
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
            let low:Int = lowY(rawPointsP)
            let high:Int = highY(rawPointsP)
            let diffL:Int = low/20
            let diffH:Int = high/20
            score = score! + diffL + diffH
        }
        readyA.hidden = false
        readyA.enabled = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
