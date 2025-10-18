//
//  FeedViewController.swift
//  AppModulo
//
//  Created by Yibriam on 18/10/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var firstCaption: UILabel!
    @IBOutlet weak var secondCaption: UILabel!
    @IBOutlet weak var thirdCaption: UILabel!
    
    var pictureType: PictureType = .dog
    var showCaption: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        showOrHideCaptions()
        setImageAndCaptions()

        // Do any additional setup after loading the view.
    }
    
    private func showOrHideCaptions() {
        firstCaption.isHidden = !showCaption
        secondCaption.isHidden = !showCaption
        thirdCaption.isHidden = !showCaption
    }
    
    private func setImageAndCaptions() {
        let captionedImages = pictureType.captionedImages
        firstCaption.text = captionedImages[0].caption
        secondCaption.text = captionedImages[1].caption
        thirdCaption.text = captionedImages[2].caption
        
        firstImageView.image = captionedImages[0].image
        secondImageView.image = captionedImages[1].image
        thirdImageView.image = captionedImages[2].image
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
