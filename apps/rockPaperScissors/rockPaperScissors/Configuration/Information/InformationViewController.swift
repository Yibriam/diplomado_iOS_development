//
//  InformationViewController.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTextView()
    }
    
    private func configureTextView() {
        infoTextView.isEditable = false
        infoTextView.textAlignment = .left
        infoTextView.font = UIFont.systemFont(ofSize: 16)
        
        infoTextView.text = """
        Rock, Paper, Scissors Rules

        • Rock beats Scissors
        • Scissors beats Paper
        • Paper beats Rock

        Players choose simultaneously. The winner is determined by the rules above.

        Acknowledgments:
        Created by Yibriam
        """
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
