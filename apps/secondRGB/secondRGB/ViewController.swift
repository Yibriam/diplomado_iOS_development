//
//  ViewController.swift
//  secondRGB
//
//  Created by Yibriam on 17/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBAction func sliderRed(_ sender: AnyObject) {
        
        self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
        redLabel.text = String(redSlider.value * 255)
    }
    
    @IBAction func sliderGreen(_ sender: AnyObject) {
        
        self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
        greenLabel.text = String(greenSlider.value * 255)
    }
    
    @IBAction func sliderBlue(_ sender: AnyObject) {
        
        self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
        blueLabel.text = String(blueSlider.value * 255)
    }

    
    @IBAction func resetBackground(_ sender: Any) {
        redSlider.value = 0.5
        greenSlider.value = 0.5
        blueSlider.value = 0.5
        
        redLabel.text = String(redSlider.value * 255)
        greenLabel.text = String(redSlider.value * 255)
        blueLabel.text = String(redSlider.value * 255)
        
        view.backgroundColor = UIColor(red: 127.5, green: 127.5, blue: 127.5, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


}

