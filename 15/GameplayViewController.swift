//
//  ViewController.swift
//  spaccaquindici
//
//  Created by  Luca Paterlini on 07/09/16.
//  Copyright © 2016 luca paterlini. All rights reserved.
//

import UIKit


class GameplayViewController: UIViewController,timedelagation {


    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var emptyCell: UIButton!
    @IBOutlet weak var gameView: UIView!
    
    var gameData =  gameModel()
    var ImageBaseName = String()
    var loops=50 // difficulty level
    var seconds = 0 {
        didSet{
            timerLabel.text = "\(seconds)"
        }
    }

    // swao the position of two picture frgments
    func change_position(a:UIButton,b:UIButton){
        let diffy=abs(abs(a.frame.origin.y - b.frame.origin.y)-a.frame.size.height)
        let diffx=abs(abs(a.frame.origin.x - b.frame.origin.x)-a.frame.size.width)
        if (a.frame.origin.x == b.frame.origin.x && diffy<15.0)||(a.frame.origin.y == b.frame.origin.y && diffx<15.0)
        {
            UIView.animateWithDuration(0.2, animations: {
            swap(&a.frame.origin.x,&b.frame.origin.x)
            swap(&a.frame.origin.y,&b.frame.origin.y)
            })
        }
    }
    
    func gameWon () {
        let alertController = UIAlertController(title: "You Won!", message: "You won the game in \(timerLabel.text!)", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.gameData.startGame(self.gameView,n_loops: self.loops)
        }
        let cancelAction = UIAlertAction(title: "Back", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // change the empty cell with the currently selected one
    @IBAction func move(sender: UIButton) {
        change_position(sender,b: emptyCell)
        if gameData.final_check(gameView) && gameData.timerIsOn{
            gameData.stopTime()
            gameWon()

        }
    }
    
    func labelUpdate(sender_seconds: Int){ seconds = sender_seconds}
    

    override func viewDidAppear(animated: Bool) {
        gameData.startGame(gameView, n_loops: loops)
    }
    
    override func viewWillAppear(animated: Bool) {
        gameData.preload(gameView, name: ImageBaseName)
        gameData.dataSource = self
        
    }

}

