//
//  InitialViewController.swift
//  AddingGame
//
//  Created by Vipul Singh on 4/2/19.
//  Copyright © 2019 Vipul Singh. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    //create outlets
    //score
    @IBOutlet weak var scoreLabel:UILabel?
    //input text field
    @IBOutlet weak var inputField:UITextField?
    //number display label
    @IBOutlet weak var numbersDisplayLabel:UILabel?
    
    //create score property
    var score : Int = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //starting point for our game
        //set rand number label
        // update score label
        
        setRandomNumberLabel()
        updateScore()
        
        //when somebody types something in, we want to respond back to them
        inputField?.addTarget(self, action: #selector(textFieldChanged(textField:)), for:UIControl.Event.editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    //method for updating the socres label
    func updateScore()
    {
        
        scoreLabel?.text = "\(score)"
    }
    
    func setRandomNumberLabel()
    {
        numbersDisplayLabel?.text = generateRandomNumbers()
    }
    @objc func textFieldChanged(textField:UITextField)
    {
        //want to make sure text is 5 characters
        if inputField?.text?.characters.count ?? 0 < 4
        {return}
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
                score = score + 1
            }
            else
            {
                print("Incorrect!")
                score = score - 1
            }
        }
        setRandomNumberLabel()
        updateScore()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
            var digit:Int=Int(arc4random_uniform(8) + 1)
            
            
            //append string value "digit" to result
            result += "\(digit)"
        }
        
        return result
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
