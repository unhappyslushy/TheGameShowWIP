//
//  ViewController.swift
//  The_Game_Show
//
//  Created by Jakob Thoms on 2018-10-29.
//  Copyright © 2018 Phidgets. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    
        
        // do stuff with the labels view
    
    
    @IBOutlet weak var redScore: UILabel!
    @IBOutlet weak var grnScore: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    
    let button0 = DigitalInput() // RED Button
    let button1 = DigitalInput() // GREEN Button
    let ledArray = [DigitalOutput(), DigitalOutput()]
    var isReady = true
    var score1 = 0
    var score2 = 0
    let questionArray = ["Calgary is in the province of Alberta", "BC is a terrible place", "Ottawa is Canadas Capital"]
    let scoreArray = ["Zero","One","Two","Three", "Winner"]
    var n : Int = 0 //This counts our question array
    var g : Int = 0 //This counts the green score
    var r : Int = 0 //This counts the red score
    func attach_handler(sender: Phidget){
        do{
            let hubPort = try sender.getHubPort()
            if(hubPort == 0){
                print("Button 0 Attached")
            }
            else if (hubPort == 1){
                print("Button 1 Attached")
            }
            else if (hubPort == 2){
                print("LED 2 Attached") //RED LED
            }
            else {
                print("LED 3 Attached") //GREEN LED
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    
    func state_change_button0(sender:DigitalInput, state:Bool){
        
        
        do{
        if(state == true){
            print("Button 0 Pressed")
            
            if(isReady == true){
                try ledArray[0].setState(true)
                print("our if statement worked")
                isReady = false
                
                
            }
            else {
               //try ledArray[0].setState(false)
            }
            
        }
        else{
            print("Button 0 Not Pressed")
             //try ledArray[0].setState(false)
        }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
        }
    
    
    func state_change_button1(sender:DigitalInput, state:Bool){
        do{
            if(state == true){
                print("Button 1 Pressed")
                
                if(isReady == true){
                    try ledArray[1].setState(true)
                    print("our if statement worked")
                    isReady = false
                    
                    
                    
                }
            }
            else{
               
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
            

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do{

            //enable net Discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
           
            //address digital input
            try button0.setHubPort(0)
            try button1.setHubPort(1)
            
            //add event handler
            try button0.setDeviceSerialNumber(528028)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528028)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            let _ = button0.stateChange.addHandler(state_change_button0)
            let _ = button1.stateChange.addHandler(state_change_button1)
            
            //open
            try button0.open()
            try button1.open()
            
            for i in 0..<ledArray.count{
               try ledArray[i].setDeviceSerialNumber(528028)
               try ledArray[i].setHubPort(i + 2)
               try ledArray[i].setIsHubPortDevice(true)
               let _ = ledArray[i].attach.addHandler(attach_handler)
               try ledArray[i].open()
            }
            
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
        //Catch Errors Here
        }
        
        
        
        newPageQuestions()
       
    }
    
    

    
    
    
    
    func newPageQuestions() {
        
        print(n)
        questionLabel.text = questionArray[n]
       
       
    }
    
    
    
    @IBAction func trueButton(_ sender: Any) {
       
        if (n < 1) {
            n += 1
            newPageQuestions()
            g += 1
            grnScore.text = scoreArray[g]
            do {
                
                try ledArray[1].setState(true)
                
                
            } catch let err as PhidgetError{
                print("Phidget Error " + err.description)
            } catch{
                //catch other errors here
            }
            
        }
        else if (n < 2) {
            n += 1
            newPageQuestions()
            g += 1
            grnScore.text = scoreArray[g]
            do {
                
                try ledArray[1].setState(false)
                
            } catch let err as PhidgetError{
                print("Phidget Error " + err.description)
            } catch{
                //catch other errors here
            }
            
        }
        else if (n < 3) {
            questionLabel.text = "Congrats To The Winning Team!"
            n += 1
            g += 1
            grnScore.text = scoreArray[g]
        }
       else if (n > 3) {
            questionLabel.text = "Congrats To The Winning Team!"
            grnScore.text = scoreArray[g]
       }
    }
    
    
    
    @IBAction func falseButton(_ sender: Any) {
        
        
        if (n < 1) {
            n += 1
            newPageQuestions()
            grnScore.text = scoreArray[g]
            isReady = true
            
            
            do {
            
                try ledArray[1].setState(false)
                try ledArray[0].setState(true)
            } catch let err as PhidgetError{
                print("Phidget Error " + err.description)
            } catch{
                //catch other errors here
            }
            
        }
        else if (n < 2) {
            n += 1
            newPageQuestions()
           
            grnScore.text = scoreArray[g]
            isReady = true
            
            do {
                
                
                try ledArray[1].setState(false)
                
            } catch let err as PhidgetError{
                print("Phidget Error " + err.description)
            } catch{
                //catch other errors here
            }
        }
        else if (n < 3) {
            questionLabel.text = "Congrats To The Winning Team!"
            grnScore.text = scoreArray[g]
        }
        else if (n < 4) {
            questionLabel.text = "Congrats To The Winning Team!"
            grnScore.text = scoreArray[g]
        }
    }

}




// need to add true to each questions as the correct answer
//need to also link the point scoring to grnScore and redScore
