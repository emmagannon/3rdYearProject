//
//  ResultVC.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 03/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//


import UIKit
import AVFoundation

var applauseURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Applause", ofType: "wav")!)
var PassSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PassSound", ofType: "mp3")!)
var FailSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("FailSound", ofType: "wav")!)
var CheerURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Cheer", ofType: "mp3")!)
var FailURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Fail", ofType: "wav")!)
var sadURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bensound-sunny", ofType: "mp3")!)

var sadAP = AVAudioPlayer()
var applauseAP = AVAudioPlayer()
var FailAP = AVAudioPlayer()
var PassSoundAP = AVAudioPlayer()
var FailSoundAP = AVAudioPlayer()
var CheerAP = AVAudioPlayer()
var passAudioPlayer = AVAudioPlayer()

class ResultVC: UIViewController {
    

    @IBOutlet weak var goAfterN: UIButton!
    @IBAction func goAfterN(sender: UIButton) {
        ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var backToN: UIButton!
    @IBAction func backToN(sender: UIButton) {
        ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var goAfterS: UIButton!
    @IBAction func goAfterS(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var backToS: UIButton!
    @IBAction func backToS(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var goAfterA: UIButton!
    @IBAction func goAfterA(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var backToA: UIButton!
    @IBAction func backToA(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    

    
    @IBOutlet weak var goAfterP: UIButton!
    @IBAction func goAfterP(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var backToP: UIButton!
    @IBAction func backToP(sender: UIButton) {
         ButtonAudioPlayer.play()
    }
    
    @IBOutlet weak var fail: UIImageView!
    @IBOutlet weak var pass: UIImageView!

    
    var score: Int?
    var letter = ""
    var pf = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        hide(letter)
         if(score > 3){
            pf = "f"
            pass.hidden = true
            sadAP.play()
            FailSoundAP.play()
            if(MenuAudioPlayer.playing){
                MenuAudioPlayer.pause()
            }
            if(lessonAP.playing){
                lessonAP.pause()
            }

        }
        else if (score < 4){
            pf = "p"
            fail.hidden = true
            
            do{
                try applauseAP = AVAudioPlayer(contentsOfURL: applauseURL)
                try PassSoundAP = AVAudioPlayer(contentsOfURL: PassSoundURL)
                try CheerAP = AVAudioPlayer(contentsOfURL: CheerURL)
            }catch _ {}
            
            PassSoundAP.play()
            applauseAP.play()
            CheerAP.play()
        }
        if(letter == "n"){
            if(pf == "f"){
                print("fail")
                goAfterN.hidden = true
                goAfterN.enabled = false
            }
            else{
                print("pass")
                backToN.hidden = true
                backToN.enabled = false
            }
        }
        else if(letter == "p"){
            if(pf == "p"){
                print("pass")
                backToP.hidden = true
                backToP.enabled = false
            }
            else{
                print("fail")
                goAfterP.hidden = true
                goAfterP.enabled = false
            }
        }
        else if(letter == "a"){
            if(pf == "f"){
                
                goAfterA.hidden = true
                goAfterA.enabled = false
            }
            else{
                backToA.hidden = true
                backToA.enabled = false
            }
        }
        else if(letter == "s"){
            if(pf == "f"){
                goAfterS.hidden = true
                goAfterS.enabled = false
            }
            else{
                backToS.hidden = true
                backToS.enabled = false
            }
        }

    }

    func hide(letter: String){
        if(letter != "p"){
            print("hideP")
            hideP()
        }
        if(letter != "s"){
            print("hideS")
            hideS()
        }
        if(letter != "a"){
            print("hideA")
            hideA()
        }
        if(letter != "n"){
            print("hideN")
            hideN()
        }
    }

    func hideN(){
        goAfterN.hidden = true
        goAfterN.enabled = false
        backToN.hidden = true
        backToN.enabled = false
    }
    
    func hideP(){
        backToP.hidden = true
        backToP.enabled = false
        goAfterP.hidden = true
        goAfterP.enabled = false
    }
    
    func hideA(){
        backToA.hidden = true
        backToA.enabled = false
        goAfterA.hidden = true
        goAfterA.enabled = false
    }
    
    func hideS(){
        backToS.hidden = true
        backToS.enabled = false
        goAfterS.hidden = true
        goAfterS.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}