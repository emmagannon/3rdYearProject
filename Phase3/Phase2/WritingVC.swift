//
//  WritingVC.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 15/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit
import AVFoundation

var MenuURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bensound-jazzyfrenchy", ofType: "mp3")!)
var buttonURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ButtonPush", ofType: "wav")!)
var lessonURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bensound-ukulele", ofType: "mp3")!)

var lessonAP = AVAudioPlayer()
var ButtonAudioPlayer = AVAudioPlayer()
var MenuAudioPlayer = AVAudioPlayer()

class WritingVC: UIViewController {
    
    var rawPoints:[Int] = []
    var recogniser:PathRecogniser?
    var score: Int? = 0

    

    @IBOutlet weak var renderView: RenderView!
    //@IBOutlet var drawLine: DrawLine!
    @IBOutlet weak var ready: UIButton!
    
    @IBAction func buttonSound(sender: UIButton) {
        do{
            try ButtonAudioPlayer = AVAudioPlayer(contentsOfURL: buttonURL)
        }catch _ {}
        ButtonAudioPlayer.play()
    }

    
    override func viewDidLoad() {
        
        do{
            try MenuAudioPlayer = AVAudioPlayer(contentsOfURL: MenuURL)
            try lessonAP = AVAudioPlayer(contentsOfURL: lessonURL)
            try FailSoundAP = AVAudioPlayer(contentsOfURL: FailSoundURL)
            try sadAP = AVAudioPlayer(contentsOfURL: sadURL)
        }catch _ {}
        if(sadAP.playing){
            sadAP.stop()
        }
        MenuAudioPlayer.play()

        let recogniser = PathRecogniser(sliceCount: 8, deltaMove: 16.0)
        ready.enabled = false
        ready.hidden = true
        
        recogniser.addModel(PathModel(directions: [2,6,7,0,1,2], datas:"n"))
        
        
        self.recogniser = recogniser
        
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "nScore"){
            let destination = segue.destinationViewController as! ResultVC
            destination.score = score
            destination.letter = "n"
        }
    }
    
    func lowY(points: [Int]) ->Int{
        var counter: Int = 3
        var lowest: Int = points[1]
        let secondLowest: Int = points.last!
        while (counter < points.count){
            if(points[counter] > lowest){
                lowest = points[counter]
            }
            if(points.count > (counter + 1)){
                if(points[counter + 2] < lowest){
                    break
                }
            }
            counter += 2
        }
        return (abs(lowest - secondLowest))
    }
    
    func highY(points: [Int])->Int {
        var counter: Int = 3
        var highest: Int = 0
        var temp: Int = 0
        let secondHighest: Int = points[1]
        while (counter < points.count){
            if(points.count > (counter + 2)){
                if(points[counter] > points[counter+2]){
                    temp = points[counter]
                    highest = points[counter+2]
                }
            }
            if(temp != 0 && highest > points[counter]){
                highest = points[counter]
            }
            counter += 2
        }
        return (abs(highest - secondHighest))
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        rawPoints.removeAll()
        viewDidLoad()
        self.renderView.pointsToDraw = rawPoints
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        rawPoints = []
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInView(view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
        
        self.renderView.pointsToDraw = rawPoints
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        var path:Path = Path()
        path.addPointFromRaw(rawPoints)
        if(rawPoints.count > 4){
            let low:Int = lowY(rawPoints)
            let high:Int = highY(rawPoints)
            let diffL:Int = low/30
            let diffH:Int = high/30
            score = score! + diffL + diffH
        }
        ready.hidden = false
        ready.enabled = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
