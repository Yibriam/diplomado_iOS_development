//
//  ListViewController.swift
//  shoppingApp
//
//  Created by Yibriam on 07/11/25.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var itemsLabel: UILabel!
    var selectedItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        itemsLabel.text = selectedItems.joined(separator: ", ")
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
