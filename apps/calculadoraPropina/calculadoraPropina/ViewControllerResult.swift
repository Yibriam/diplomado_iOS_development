//
//  ViewControllerResult.swift
//  calculadoraPropina
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewControllerResult: UIViewController {
    
    var tipResult: String?

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = tipResult {
            resultLabel.text = result
        }
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
