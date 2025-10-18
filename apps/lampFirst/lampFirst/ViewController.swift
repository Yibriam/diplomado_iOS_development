//
//  ViewController.swift
//  lampFirst
//
//  Created by Yibriam on 17/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    var isButtonOn = false
    var isWhiteBackground = true
    
    @IBOutlet weak var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isButtonOn {
            myButton.setTitle("Turn OFF", for: .normal)
        } else {
            myButton.setTitle("Turn ON", for: .normal)
        }
        isButtonOn.toggle()
    }
    
    @IBAction func turnOnOffBackground(_ sender: Any) {
        if isWhiteBackground {
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        } else {
            view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
        isWhiteBackground.toggle()
    }
}

