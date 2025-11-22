//
//  AlbumCell.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class AlbumCell: UITableViewCell {
    let albumImageView = UIImageView()
    let albumTitleLabel = UILabel()
    let releaseYearLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.clipsToBounds = true
        albumImageView.layer.cornerRadius = 6
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        albumTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        releaseYearLabel.font = UIFont.systemFont(ofSize: 14)
        releaseYearLabel.textColor = .secondaryLabel
        
        let stack = UIStackView(arrangedSubviews: [albumTitleLabel, releaseYearLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            albumImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: 100),
            albumImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stack.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    func configure(with album: Album) {
        albumTitleLabel.text = album.title
        releaseYearLabel.text = "Released: \(album.releaseYear)"
        albumImageView.image = UIImage(named: album.imageName) ?? UIImage(systemName: "photo")
    }

}
