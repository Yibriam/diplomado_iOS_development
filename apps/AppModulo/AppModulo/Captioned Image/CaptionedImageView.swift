//
//  CaptionedImage.swift
//  FakestagramShare
//
//  Created by alberto on 25/10/25.
//

import UIKit

final class CaptionedImageView: UIView {
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var caption: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    var showCaption: Bool = false {
        didSet{
            caption.isHidden = !showCaption
        }
    }
    
    var captionedImage: CaptionedImage? {
        didSet{
            caption.text = captionedImage?.caption
            image.image = captionedImage?.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSatckViewContainer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setSatckViewContainer()
    }
    
    private func setSatckViewContainer(){
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(caption)
    }
}
