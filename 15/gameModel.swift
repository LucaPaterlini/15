//
//  gameModel.swift
//  spaccaquindici
//
//  Created by  Luca Paterlini on 08/09/16.
//  Copyright © 2016 luca paterlini. All rights reserved.
//

import UIKit

protocol timedelagation :class{
    func labelUpdate(sender_seconds: Int)
}

class gameModel: UIView {
    
    let triggerTime = (Int64(NSEC_PER_SEC) * 2)
    
    var gametimer = NSTimer()
    var timerIsOn = false
    var dictOfy = [String:CGFloat]()
    var dictOfx = [String:CGFloat]()
    var local_seconds = 0
    weak var dataSource: timedelagation?
    
    
    func preload(sender: UIView,name: String){
        sender.setNeedsDisplay()
        for case let button as UIButton in  sender.subviews {
            if button.titleLabel!.text != nil {
                let name = name+"_\(button.titleLabel!.text!)"
                print(name)
                button.setImage(UIImage(named:name), forState: .Normal)
            }
        }
    }
    
    
    func startGame(sender: UIView,n_loops:Int){
        // This functions save on an array the x and y of every fragment of the picture
        for case let button as UIButton in  sender.subviews {
            if let label = button.titleLabel!.text{
                dictOfx[label] = button.frame.origin.x
                dictOfy[label] = button.frame.origin.y
                
            }
        }
        // The following pice of code randomly execute the click procedure n times whit n equal to the difficulty of the puzzle
        for _ in 1...n_loops{
            for case let button as UIButton in  sender.subviews {
                let random = Int(arc4random_uniform(3))
                if random==1{
                    button.sendActionsForControlEvents(.TouchUpInside)
                }
            }
        }
        startTime()
    }
    
    func startTime() {
        local_seconds = 0
        dataSource?.labelUpdate(local_seconds)
        if timerIsOn == false{
            gametimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    func stopTime() {
        gametimer.invalidate()
        timerIsOn = false
        
    }
    
    func updateTimer(){
        local_seconds++
        dataSource?.labelUpdate(local_seconds)
    
    }
    //This functions check the conditions, ara all the fragment at them starting position?
    //If the condition it's true the current game ends and the score label appears. 
    //The score is based only on time used to solve the puzzle.
    func final_check(sender: UIView)->Bool{
        for case let button as UIButton in  sender.subviews {
            if let label=button.titleLabel!.text {
                if (dictOfx[label] != button.frame.origin.x) || (dictOfy[label] != button.frame.origin.y) {return false}
                }
        }
        return true
    }
}
