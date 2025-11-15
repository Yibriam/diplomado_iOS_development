//
//  HomeViewController.swift
//  AppModulo
//
//  Created by Yibriam on 11/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var customView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.picturesButton.setImage(UIImage(systemName: customView.imageType.isOn ? "dog.fill" : "cat.fill"), for: .normal)
        customView.customTextField.isEditable = customView.customTextSwitch.isOn
        setBarButtonItemGroup()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func informationButtonTapped(_ sender: Any) {
        if customView.customTextSwitch.isOn {
            if customView.customTextField.text != "" {
                navigateToInformationViewController()
                // performSegue(withIdentifier: "HomeInformationSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: nil, message: "Add custom text", preferredStyle: .alert); alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alertController, animated: true)
            }
        } else {
            // HomeInformationSegue
            
            navigateToInformationViewController()
        }
    }
    
    private func setBarButtonItemGroup() {
        let logoutButton = UIBarButtonItem(title: "Logout", image: UIImage(systemName: "multiply.circle.fill"), target: self, action: #selector(logout))
        let informationButton = UIBarButtonItem(title: "Information", image: UIImage(systemName: "info.circle.fill"), target: self, action: #selector(informationButtonTapped))
        navigationItem.centerItemGroups = [UIBarButtonItemGroup.fixedGroup(items: [logoutButton, informationButton])]
    }
    
    @objc
    private func logout(){
        navigationController?.dismiss(animated: true)
    }
    
    private func navigateToInformationViewController() {
        let infoViewController = InformationViewController()
        if customView.customTextSwitch.isOn {
            infoViewController.informationText = customView.customTextField.text
        }
        present(infoViewController, animated: true)
    }
    
    @IBAction func imageTypeSwitchValueChanged(_ sender: UISwitch) {
        customView.picturesButton.setImage(UIImage(systemName: sender.isOn ? "dog.fill" : "cat.fill"), for: .normal)
    }
    
    @IBAction func captionSwitchValueChanged(_ sender: UISwitch) {
        customView.customTextField.isEditable = sender.isOn
    }
    
    @IBAction func picsButtonTapped(_ sender: UIButton) {
        let feedViewController = FeedViewController(nibName: nil, bundle: nil)
        feedViewController.pictureType = customView.imageType.isOn ? .dog : .cat
        feedViewController.showCaption = customView.captionSwitch.isOn
        navigationController?.pushViewController(feedViewController, animated: true)
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
