//
//  SwipeCardsContainer.swift
//  CardViews
//
//  Created by Katalin Neda on 03/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

protocol CardsDataSource {
    func numberOfCards() -> Int
    func card(at index: Int) -> UIView
}

class CardsContainer: UIView {
    
    // MARK: - Properties
    
    var maximumVisibleCards: Int = 4
    
    var dataSource: CardsDataSource? {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Private properties
    
    private var numberOfCards = 0
    private var cards: [Card] = []
    private var padding: CGFloat = 10
    private var cardHeight: CGFloat = 0
    
    private var leftCards = 0
    
    private var isRemovingCard = false
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !isRemovingCard else {
            isRemovingCard.toggle()
            return
        }
        
        cardHeight = bounds.size.height * 0.7
        reloadData()
    }
    

    public func reloadData() {
        removeAll()
        guard let dataSource = dataSource else { return }
        numberOfCards = dataSource.numberOfCards()
        
        for index in 0..<min(numberOfCards, maximumVisibleCards) {
            let contentView = dataSource.card(at: index)
            let card = Card(content: contentView)
            card.delegate = self
            cards.append(card)
            addCard(at: index, view: card)
        }
        
        leftCards = numberOfCards - min(numberOfCards, maximumVisibleCards)
    }
    
    // MARK: - Private methods
    
    private func addCard(at index: Int, view: Card) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, at: 0)
            
        view.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(index) * padding).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        view.heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
    }
    
    private func removeAll() {
        for card in cards {
            card.removeFromSuperview()
        }
        cards = []
    }
}

// MARL: - CardDelegate

extension CardsContainer: CardDelegate {

    func didRemoveCard(_ card: Card) {
        isRemovingCard = true
        
        card.removeFromSuperview()
     
        guard let dataSource = dataSource, leftCards != 0 else { return }
        
        let newIndex = numberOfCards - (numberOfCards - leftCards)
        
        
//        addCardView(cardView: datasource.card(at: newIndex), atIndex: visibleCards - 1)
//        for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
//            UIView.animate(withDuration: 0.2, animations: {
//            cardView.center = self.center
//              self.addCardFrame(index: cardIndex, cardView: cardView)
//                self.layoutIfNeeded()
//            })
//        }
        
//        isRemovingCard = false
        
    }
}
