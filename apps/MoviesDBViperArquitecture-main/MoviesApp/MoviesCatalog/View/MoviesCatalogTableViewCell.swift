//
//  MoviesCatalogTableViewCell.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 10/12/24.
//

import UIKit
import Kingfisher

class MoviesCatalogTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: MovieCellViewModel){
        movieImage.kf.setImage(with: viewModel.imageURL)
        titileLabel.text = viewModel.title
        voteLabel.text = "Average: \(round(viewModel.vote * 10) / 10)"
        overViewLabel.text = viewModel.overview
    }
}
