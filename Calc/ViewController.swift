//
//  ViewController.swift
//  Calc
//
//  Created by Tony Merritt on 06/08/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Plus = "+"
        case Clear = "C"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outPutLabel: UILabel!
    
    var buttonSound:AVAudioPlayer!
    var runningnumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let path = NSBundle.mainBundle ().pathForResource("btn", ofType: "wav")
     
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        
        do {
           try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
            
        }
    }
    @IBAction func numberPressed (button: UIButton!){
      playSound()
        
        runningnumber += "\(button.tag)"
        outPutLabel.text = runningnumber
    }

    @IBAction func onDividPressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onTimesPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onMinusPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(Operation.Plus)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    @IBAction func onClearPressed(sender: AnyObject) {
       processOperation(Operation.Clear)
        runningnumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = "0"
        outPutLabel.text = result
    }
    
    
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run sum math
            
            // a user slected an operator bu then selected a second opperator without a number
            
            if runningnumber != "" {
                rightValString = runningnumber
            runningnumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            }else if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            }else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            }else if currentOperation == Operation.Plus {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            }else if currentOperation == Operation.Clear {
                result = "0"
                }
        
            leftValString = result
            outPutLabel.text = result
                
            }
        
            currentOperation = op
        
        }else{
            //This is the first time this is run
            leftValString = runningnumber
            runningnumber =  ""
            currentOperation = op
        }
        
    }
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
}


