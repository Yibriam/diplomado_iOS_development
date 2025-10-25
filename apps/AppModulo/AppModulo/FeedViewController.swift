//
//  FeedViewController.swift
//  AppModulo
//
//  Created by Yibriam on 18/10/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var firstCaptionedImageView: CaptionedImageView!
    @IBOutlet weak var secondCaptionedImageView: CaptionedImageView!
    @IBOutlet weak var thirdCaptionedImageView: CaptionedImageView!

    
    var pictureType: PictureType = .dog
    var showCaption: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        showOrHideCaptions()
        setImageAndCaptions()

        // Do any additional setup after loading the view.
    }
    
    private func showOrHideCaptions() {
        firstCaptionedImageView.isHidden = showCaption
        firstCaptionedImageView.isHidden = showCaption
        firstCaptionedImageView.isHidden = showCaption
    }
    
    private func setImageAndCaptions() {
        let captionedImages = pictureType.captionedImages
        firstCaptionedImageView.captionedImage = captionedImages[0]
        secondCaptionedImageView.captionedImage = captionedImages[1]
        thirdCaptionedImageView.captionedImage = captionedImages[2]
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
