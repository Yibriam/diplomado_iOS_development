//
//  HomeViewController.swift
//  AppModulo
//
//  Created by Yibriam on 11/10/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageType: UISwitch!
    @IBOutlet weak var captionSwitch: UISwitch!
    @IBOutlet weak var customTextSwitch: UISwitch!
    @IBOutlet weak var picsButton: UIButton!
    @IBOutlet weak var customTextField: UITextView! {
        didSet {
            customTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picsButton.setImage(UIImage(systemName: imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
        customTextField.isEditable = customTextSwitch.isOn

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let feedViewController = segue.destination as? FeedViewController {
            feedViewController.pictureType = imageType.isOn ? .dog : .cat
            feedViewController.showCaption = captionSwitch.isOn
        } else if segue.identifier == "HomeInformationSegue", let  informationViewController = segue.destination as? informationViewController {
            if customTextSwitch.isOn {
                informationViewController.informationText = customTextField.text
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction func informationButtonTapped(_ sender: Any) {
        if customTextSwitch.isOn {
            if customTextField.text != "" {
                // HomeInformationSegue
                performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: nil, message: "Add custom text", preferredStyle: .alert); alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alertController, animated: true)
            }
        } else {
            performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
            // HomeInformationSegue
        }
    }
    
    @IBAction func imageTypeSwitchValueChanged(_ sender: UISwitch) {
        picsButton.setImage(UIImage(systemName: sender.isOn ? "dog.fill" : "cat.fill"), for: .normal)
    }
    
    @IBAction func captionSwitchValueChanged(_ sender: UISwitch) {
        customTextField.isEditable = sender.isOn
    }

}

extension HomeViewController: UITextViewDelegate {
    func textView( _ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let allowedCharacterSet =
        CharacterSet.alphanumerics.union(CharacterSet.whitespacesAndNewlines)
        let maxCharacterCount = 150
        let currentCharacters = textView.text.count
        let finalCharacterCount = currentCharacters - range.length + text.count
        
        return text == "" || (CharacterSet(charactersIn: text).isSubset(of: allowedCharacterSet) && finalCharacterCount <= maxCharacterCount)
    }
}
