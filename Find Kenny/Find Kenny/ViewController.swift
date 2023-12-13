//
//  ViewController.swift
//  Find Kenny
//
//  Created by Pabitra Ranjan Sahoo   on 11/12/23.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var counter = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var kennyArray = [UIImageView]()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var k1: UIImageView!
    @IBOutlet weak var k2: UIImageView!
    @IBOutlet weak var k3: UIImageView!
    @IBOutlet weak var k4: UIImageView!
    @IBOutlet weak var k5: UIImageView!
    @IBOutlet weak var k6: UIImageView!
    @IBOutlet weak var k7: UIImageView!
    @IBOutlet weak var k8: UIImageView!
    @IBOutlet weak var k9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //high score check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        kennyArray = [k1,k2,k3,k4,k5,k6,k7,k8,k9]
        
        for i in 0..<kennyArray.count {
            kennyArray[i].isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, 
                                                    action: #selector(increaseScore))
            kennyArray[i].addGestureRecognizer(recognizer)
        }
        
        //timer
        
        counter = 30
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(countDown),
                                     userInfo: nil, 
                                     repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3,
                                         target: self,
                                         selector: #selector(hidekenny),
                                         userInfo: nil,
                                         repeats: true)
       // hidekenny()
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func hidekenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        kennyArray[Int.random(in: 0..<kennyArray.count)].isHidden = false
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //highScore saving
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore :\(self.highScore)"
                UserDefaults.standard.set(self.highScore,
                                          forKey: "highScore")
            }
            
            //alert
            
            let alert = UIAlertController(title: "Time's Up",
                                          message: "Do you want to play again?",
                                          preferredStyle: UIAlertController.Style.alert)
            
            let okbutton = UIAlertAction(title: "No", 
                                         style: UIAlertAction.Style.cancel ,
                                         handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay",
                                             style: UIAlertAction.Style.default) {[self]
                (UIAlertAction) in
                
              //replay button
                self.score = 0
                self.scoreLabel.text = "Score :\(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, 
                                                  target: self,
                                                  selector: #selector(self.countDown),
                                                  userInfo: nil,
                                                  repeats: true)
                
                hideTimer = Timer.scheduledTimer(timeInterval: 0.3, 
                                                 target: self,
                                                 selector: #selector(self.hidekenny),
                                                 userInfo: nil,
                                                 repeats: true)
                
            }
            alert.addAction(okbutton)
            alert.addAction(replayButton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
}


