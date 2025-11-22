//
//  SongCell.swift
//  musicBands
//
//  Created by Yibriam on 21/11/25.
//

import UIKit

class SongCell: UITableViewCell {
    let songTitleLabel = UILabel()
    let durationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songTitleLabel.font = UIFont.systemFont(ofSize: 16)
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .secondaryLabel
        
        let stack = UIStackView(arrangedSubviews: [songTitleLabel, durationLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    func configure(with song: Song) {
        songTitleLabel.text = song.title
        durationLabel.text = song.duration
    }
}
