//
//  PickGameViewController.swift
//  Sheep
//
//  Created by N Shey Johnson on 2/22/20.
//  Copyright © 2020 HAVOC, LLC. All rights reserved.
//

import UIKit

class PickGameViewController: UIViewController {

    let ANSWER_SHEEP = 1
    let ANSWER_GOAT = 2
    
    var answer = 0
    var score = 0
    var timer = 60

    @IBOutlet var scoreLbl : UILabel?
    @IBOutlet var timerLbl : UILabel?
    @IBOutlet var button1Btn : UIButton?
    @IBOutlet var button2Btn : UIButton?
    @IBOutlet var subjectIV : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLbl!.text = String(score)
        timerLbl!.text = String(timer)
        
        //subjectIV!.layer.masksToBounds = true
        //subjectIV!.contentMode = .scaleToFill
        //subjectIV!.layer.borderWidth = 5

        playGame()
    }

    func playGame() {
        doTimer()
        nextRound()
    }
    
    func doTimer() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.timer -= 1
            self.timerLbl!.text = String(self.timer)
            
            if(self.timer > 0) {
                self.doTimer()
            }
            else {
                self.endGame()
            }
        }
    }
    
    func nextRound() {

        button1Btn!.isEnabled = true
        button2Btn!.isEnabled = true
        
        button1Btn!.setBackgroundImage(UIImage(named: "normal"), for: .normal)
        button2Btn!.setBackgroundImage(UIImage(named: "normal"), for: .normal)

        if(arc4random()%2 == 1) {
            answer = ANSWER_SHEEP
            subjectIV?.image = UIImage(named: "sheep\(arc4random()%10+1)")
        }
        else {
            answer = ANSWER_GOAT
            subjectIV?.image = UIImage(named: "goat\(arc4random()%13+1)")
        }
        
        if(arc4random()%2 == 1) {
            button1Btn!.setTitle("Sheep", for:.normal)
            button1Btn!.tag = ANSWER_SHEEP
            button2Btn!.setTitle("Goat", for:.normal)
            button2Btn!.tag = ANSWER_GOAT
        }
        else {
            button1Btn!.setTitle("Goat", for:.normal)
            button1Btn!.tag = ANSWER_GOAT
            button2Btn!.setTitle("Sheep", for:.normal)
            button2Btn!.tag = ANSWER_SHEEP
        }
        
    }
    
    @IBAction func checkAnswer(sender: Any?) {
        let btn: UIButton = sender as! UIButton
        
        button1Btn!.isEnabled = false
        button2Btn!.isEnabled = false
        
        if(btn.tag == answer) {
            score += 1
            scoreLbl!.text = String(score)
            btn.setBackgroundImage(UIImage(named: "correct"), for: .normal)
        }
        else {
            btn.setBackgroundImage(UIImage(named: "wrong"), for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.nextRound()
        }
    }
    
    @IBAction func doClose() {
        dismiss(animated: true, completion: { () -> Void in
        })
    }
    
    func endGame() {
        button1Btn!.isEnabled = false
        button2Btn!.isEnabled = false

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.doClose()
        }

    }
}
