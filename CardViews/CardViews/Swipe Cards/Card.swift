//
//  SwipeCard.swift
//  CardViews
//
//  Created by Katalin Neda on 03/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

protocol CardDelegate: AnyObject {
    func didRemoveCard(_ card: Card)
}

class Card: UIView {

    // MARK: - Private properties
    
    private var shadowView: UIView!
    private var contentView: UIView!
    private var overlay: UIView!
    
    private var topConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?

    weak var delegate: CardDelegate?
    
    private var initialCenter: CGPoint

    // MARK: - Init
    
    init(content: UIView) {
        self.contentView = content
        self.initialCenter = .zero
        super.init(frame: .zero)
        
        addShadow()
        configureContentView()
        addOverlay()
        addGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initialCenter = center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func addTopAnchor(related view: UIView, constant: CGFloat) {
        if let topConstraint = topConstraint {
            topConstraint.constant = constant
            return
        }
        self.topConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        NSLayoutConstraint.activate([topConstraint!])
    }
    
    public func addLeadingAnchor(related view: UIView, constant: CGFloat) {
        if let leadingConstraint = leadingConstraint {
            leadingConstraint.constant = constant
            return
        }
        self.leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        NSLayoutConstraint.activate([leadingConstraint!])
    }
    
    public func addTrailingAnchor(related view: UIView, constant: CGFloat) {
        if let trailingConstraint = trailingConstraint {
            trailingConstraint.constant = -constant
            return
        }
        self.trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        NSLayoutConstraint.activate([trailingConstraint!])
    }
    
    public func addHeightAnchor(constant: CGFloat) {
        if let heightConstraint = heightConstraint {
            heightConstraint.constant = constant
            return
        }
        self.heightConstraint = heightAnchor.constraint(equalToConstant: constant)
        NSLayoutConstraint.activate([heightConstraint!])
    }
    
    // MARK: - Private methods
    
    private func addShadow() {
        shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowRadius = 10
        addSubview(shadowView)
           
        NSLayoutConstraint.activate([
            shadowView.leftAnchor.constraint(equalTo: leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func addOverlay() {
        overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        overlay.isHidden = true
        addSubview(overlay)
           
        NSLayoutConstraint.activate([
            overlay.leftAnchor.constraint(equalTo: leftAnchor),
            overlay.rightAnchor.constraint(equalTo: rightAnchor),
            overlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlay.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        shadowView.addSubview(contentView)
           
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: shadowView.topAnchor)
        ])
    }
    
    private func addGesture() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleGesture)))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    // MARK: - UI Actions
    
    @objc private func handleTapGesture(sender: UILongPressGestureRecognizer) {

        guard let card = sender.view as? Card else { return }

        switch sender.state {
        case .began:
            UIView.animate(withDuration: 0.1) {
                self.overlay.isHidden = false
                card.transform = CGAffineTransform(scaleX: 1.005, y: 1.005)
            }
        case .ended:
            UIView.animate(withDuration: 0.1) {
                self.overlay.isHidden = true
                card.transform = .identity
            }
        default:
            break
        }
    }
    
    @objc private func handleGesture(sender: UIPanGestureRecognizer) {

        let card = sender.view as! Card
        let point = sender.translation(in: self)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        UIView.animate(withDuration: 0.1) {
            card.center = CGPoint(x: center.x + point.x, y: center.y + point.y)
        }
        
        switch sender.state {
        case .began:
            UIView.animate(withDuration: 0.1) {
                self.overlay.isHidden = false
            }
        case .ended:
            if card.frame.minX < 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: center.x + point.x - 200, y: center.y + point.y + 75)
                    card.alpha = 0
                    self.overlay.isHidden = true
                }) { _ in
                    self.delegate?.didRemoveCard(self)
                }
            } else if card.frame.maxX > superview?.frame.width ?? 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: center.x + point.x + 400, y: center.y + point.y + 75)
                    card.alpha = 0
                    self.overlay.isHidden = true
                }) { _ in
                    self.delegate?.didRemoveCard(self)
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: self.initialCenter.x, y: 0)// self.initialCenter
                })
            }
        default:
            break
        }
        
    }
}
