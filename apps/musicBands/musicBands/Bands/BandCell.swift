//
//  BandCell.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class BandCell: UITableViewCell {
    
    let bandImageView = UIImageView()
    let bandNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bandImageView.contentMode = .scaleAspectFill
        bandImageView.clipsToBounds = true
        bandImageView.layer.cornerRadius = 8
        
        bandNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        contentView.addSubview(bandImageView)
        contentView.addSubview(bandNameLabel)
        
        bandImageView.translatesAutoresizingMaskIntoConstraints = false
        bandNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bandImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bandImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bandImageView.widthAnchor.constraint(equalToConstant: 60),
            bandImageView.heightAnchor.constraint(equalToConstant: 60),
            
            bandNameLabel.leadingAnchor.constraint(equalTo: bandImageView.trailingAnchor, constant: 15),
            bandNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bandNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    func configure(with band: Band) {
        bandNameLabel.text = band.name
        bandImageView.image = UIImage(named: "beatles")
    }
}
