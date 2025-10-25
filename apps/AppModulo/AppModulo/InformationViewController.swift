//
//  informationViewController.swift
//  AppModulo
//
//  Created by Yibriam on 18/10/25.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var informationTextView: UITextView!
    
    var informationText: String = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque laoreet vestibulum libero, at dictum dui auctor eget. Integer erat ipsum, posuere in odio ac, volutpat eleifend tellus. Fusce sit amet erat magna. Mauris aliquam quam velit, in eleifend dolor imperdiet nec. Ut placerat orci quis turpis volutpat, mattis vehicula justo lacinia. Proin sollicitudin malesuada mauris ut porta. Phasellus a dolor finibus, vulputate nunc eu, consectetur mauris. Cras ac vulputate elit. Ut nisi tellus, pharetra sed iaculis id, commodo et purus."
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        informationTextView.text = informationText
    }

}
