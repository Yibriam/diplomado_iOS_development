//
//  ViewControllerResult.swift
//  calculadoraIMC
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewControllerResult: UIViewController {
    
    var IMCResult: String?
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = IMCResult
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
