//
//  InitialViewController.swift
//  AddingGame
//
//  Created by Vipul Singh on 4/2/19.
//  Copyright © 2019 Vipul Singh. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //generate random numbers
    func generateRandomNumber() -> String
    {
        var result:String = ""
        
        for _ in 1...4
        {
            let digit = Int.random(in: 1..<9)
            
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
