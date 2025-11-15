//
//  HistoryViewController.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTextView: UITextView!
        
        var historyEntries: [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            historyTextView.isEditable = false
            historyTextView.text = historyEntries.joined(separator: "\n")
        }

}
