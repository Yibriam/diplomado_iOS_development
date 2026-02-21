//
//  PopularMoviesDetailsViewController.swift
//  MoviesApp
//
//  Created by Cristian guillermo Romero garcia on 12/12/24.
//

import UIKit
import Kingfisher

class PopularMoviesDetailsViewController: UIViewController, PopularMoviesDetailsViewProtocol {
    
    //MARK: Outlets
    @IBOutlet weak var backpathImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var runtimeImage: UIImageView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var OverViewLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //MARK: VIPER Properties
    var presenter: (any PopularMoviesDetailsPresenterProtocol)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setUpUI(){
        loader.stopAnimating()
    }

    func upDateUI(withViewModel viewModel: PopularMoviesDetailsViewModel){
        titleLabel.text = viewModel.title
        backpathImageView.kf.setImage(with: viewModel.imageURL)
        tagLine.text = viewModel.tagline
        runtimeLabel.text = "\(String( viewModel.runtime)) min"
        statusLabel.text = "Status: " + viewModel.status
        voteAverageLabel.text = "Average: \(viewModel.vote)"
        releaseDateLabel.text = "Release date: " + viewModel.date
        budgetLabel.text = "$ \(viewModel.budget) USD"
        revenueLabel.text = "$ \(viewModel.revenue) USD"
        OverViewLabel.text = viewModel.overview
    }
    
    func animateLoader(isAnimating: Bool){
        DispatchQueue.main.async {
            self.loader.isHidden = !isAnimating
            if isAnimating{
                self.loader.startAnimating()
            }else {
                self.loader.stopAnimating()
            }
        }
    }
}

