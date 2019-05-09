//
//  InitialViewController.swift
//  AddingGame
//
//  Created by Vipul Singh on 4/2/19.
//  Copyright © 2019 Vipul Singh. All rights reserved.
//

import UIKit
import MBProgressHUD //in order to use the HUD we need to add property (line 25)

class InitialViewController: UIViewController {
    
    //create outlets
    //score
    @IBOutlet weak var scoreLabel:UILabel?
    //input text field
    @IBOutlet weak var inputField:UITextField?
    //number display label
    @IBOutlet weak var numbersDisplayLabel:UILabel?
    //time label
    @IBOutlet weak var timerLabel:UILabel?
    
    //create score property
    var score : Int = 0
    
    var hud:MBProgressHUD?
    
    //variable for timer
    var timer:Timer?
    var seconds:Int = 60    //seconds
    //start timer when first answer is given

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //create a new instance of mbprogress and asssigns it to hud property
        hud = MBProgressHUD(view: self.view)
        
        if (hud != nil)
        {
            self.view.addSubview(hud!)
        }
        //starting point for our game
        //set rand number label
        // update score label
        
        setRandomNumberLabel()
        updateScore()
        
        //when somebody types something in, we want to respond back to them
        inputField?.addTarget(self, action: #selector(textFieldChange(textField:)), for:UIControl.Event.editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    //method for updating the socres label
    func updateScore()
    {
        
        scoreLabel?.text = "\(score)"
    }
    
    func updateTimerLabel()
    {
        //want to show how many minutes and seconds are left for the user
        if(timerLabel != nil)
        {
            //minutes
            let min:Int = (seconds / 60) % 60
            //seconds
            let sec:Int = seconds % 60
            
            //string formatting: will print out min and seconds and pad 0 on top of integer
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            
            timerLabel!.text = "\(min_p):\(sec_p)"
        }
    }
    
    func setRandomNumberLabel()
    {
        numbersDisplayLabel?.text = generateRandomNumbers()
    }
    @objc func textFieldChange(textField:UITextField)
    {
        //want to make sure text is 4 characters
        if inputField?.text?.count ?? 0 < 4
        {
            return
            
        }
        if  let numbers_text    = numbersDisplayLabel?.text,
            let input_text      = inputField?.text,
            let numbers = Int(numbers_text),
            let input   = Int(input_text)
        {
            //print input text
            print("Comparing: \(input_text) minus \(numbers_text) == \(input - numbers)")
            
            
            //increment or decrement score based on user input
            if(input - numbers == 1111)
            {
                print("Correct!")
                showHUDSign(isRight: true)
                score = score + 1
            }
            else
            {
                print("Incorrect!")
                showHUDSign(isRight: false)
                score = score - 1
            }
        }
        setRandomNumberLabel()
        updateScore()
        
        if (timer == nil)
        {
            //create timer with timer interval of 1 second
            //timer is going to be called every 1 second
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(doUpdateTimer), userInfo:nil, repeats:true)
        }
    }
    
    @objc func doUpdateTimer() -> Void
    {
        if(seconds > 0 && seconds <= 60)
        {
            seconds -= 1
            
            updateTimerLabel()
        }
        else if(seconds == 0)
        {
            if(timer != nil)
            {
                let alertController = UIAlertController(title: "Times Up!", message: "Your time is up! You got a score of: \(score) points.", preferredStyle: .alert)
                
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
                alertController.addAction(restartAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                score = 0
                seconds = 60
                
                updateTimerLabel()
                updateScore()
                setRandomNumberLabel()
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //method to dispay thumbs up or thumbs down
    func showHUDSign(isRight : Bool)
    {
        var imageView:UIImageView?
        
        //when answer is right show thumbs up else thumbs down if wrong
        if isRight
        {
            imageView = UIImageView(image: UIImage(named: "thumbs-up"))
        }
        else
        {
            imageView = UIImageView(image: UIImage(named: "thumbs-down"))
        }
        
        if(imageView != nil)
        {
            hud?.mode = MBProgressHUDMode.customView
            hud?.customView = imageView
            
            hud?.show(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3)
            {
                self.hud?.hide(animated: true)
                self.inputField?.text = ""
            }
        }
    }
    
    //generate random numbers
    func generateRandomNumbers() -> String
    {
        //empty string
        var result : String = ""
        
        //loop will repoeat 4 times
        for _ in 1...4
        {
            //return random value including nine
            let digit = Int.random(in: 1..<9)
            
            
            //append string value "digit" to result
            result += "\(digit)"
        }
        
        return result
    }


    

}
