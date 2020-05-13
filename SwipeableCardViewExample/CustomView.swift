//
//  CustomView.swift
//  SwipeableCardViewExample
//
//  Created by Katalin Neda on 13/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

class CustomView: UIView {

    // MARK: - Private properties
    
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addContent(image: UIImage?, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    
    private func setupView() {

        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 50)
        titleLabel.numberOfLines = 0
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50)
        ])
    }
}
