//
//  MoviesCollectionViewCell.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 11/12/24.
//

import UIKit
import Kingfisher
class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10
        // Initialization code
    }
    
    func configure(viewModel: MovieCellViewModel){
        movieImage.kf.setImage(with: viewModel.imageURL)
    }
}
