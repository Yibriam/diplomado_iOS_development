//
//  ViewControllerResult.swift
//  encuestaPreferencias
//
//  Created by Yibriam on 24/10/25.
//

import UIKit

class ViewControllerResult: UIViewController {
    
    var foodResult: String?
    var soccerResult: Bool?
    var leisureResult: String?
    
    @IBOutlet weak var foodSegment: UISegmentedControl!
    @IBOutlet weak var soccerSwitch: UISwitch!
    @IBOutlet weak var leisureLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Mostrar el texto ingresado
        leisureLabel.text = leisureResult

        // Mostrar la opción seleccionada en el UISegmentedControl
        if let food = foodResult {
            switch food {
            case "Pizza": foodSegment.selectedSegmentIndex = 0
            case "Sushi": foodSegment.selectedSegmentIndex = 1
            case "Ensalada": foodSegment.selectedSegmentIndex = 2
            case "Hamburguesa": foodSegment.selectedSegmentIndex = 3
            default: foodSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            }
        }

        // Mostrar el estado del UISwitch
        if let soccer = soccerResult {
            soccerSwitch.isOn = soccer
        }

        // Desactivar interacción
        foodSegment.isEnabled = false
        soccerSwitch.isEnabled = false
        leisureLabel.isUserInteractionEnabled = false
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
