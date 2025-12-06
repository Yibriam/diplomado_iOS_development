//
//  ColourCell.swift
//  FakestagramShare
//
//  Created by alberto on 29/11/25.
//

import UIKit

final class ColourCell: UITableViewCell {
    
    static let identifier: String = "ColourCell"
    
    private lazy var colourView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        contentView.addSubview(colourView)
        NSLayoutConstraint.activate([
            colourView.topAnchor.constraint(equalTo: contentView.topAnchor),
            colourView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colourView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colourView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colourView.image = nil
        stopAnimation()
    }
    
    func startAnimation() {
        colourView.animationImages = [.spinner]
        for factor in 2...18 {
            let degrees: Float = 20.0 * Float(factor)
            let rotatedImage = UIImage.spinner.rotate(degrees: degrees)!
            colourView.animationImages?.append(rotatedImage)
        }
        colourView.animationDuration = 1.0
        colourView.animationRepeatCount = 0
        colourView.startAnimating()
    }
    
    func stopAnimation() {
        colourView.stopAnimating()
        colourView.animationImages = nil
    }
}
