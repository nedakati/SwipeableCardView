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
        
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        cardHeight = frame.height * 0.8
        rearrange()
    }
    
    // MARK: - Public methods
    
    public func reloadData() {
        removeAll()
        guard let dataSource = dataSource else { return }
        numberOfCards = dataSource.numberOfCards()
        
        for index in 0..<min(numberOfCards, maximumVisibleCards) {
            let contentView = dataSource.card(at: index)
            createCard(from: contentView, at: index)
        }
        
        leftCards = numberOfCards - min(numberOfCards, maximumVisibleCards)
        rearrange()
    }
    
    // MARK: - Private methods
    
    private func createCard(from view: UIView, at index: Int) {
        let card = Card(content: view)
        card.delegate = self
        cards.append(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(card, at: 0)
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

        cards.remove(at: 0)
        card.removeFromSuperview()

        guard let dataSource = dataSource else { return }
        
        if leftCards != 0 {
            let startIndex = numberOfCards - leftCards
            
            let contentView = dataSource.card(at: startIndex)
            createCard(from: contentView, at: maximumVisibleCards)
            
            leftCards -= 1
        }
        
        rearrange()
    }
    
    private func rearrange() {
        for index in 0..<cards.count {
            cards[index].addTopAnchor(related: self, constant: CGFloat(index) * padding)
            cards[index].addHeightAnchor(constant: cardHeight)
            cards[index].addLeadingAnchor(related: self, constant: 10)
            cards[index].addTrailingAnchor(related: self, constant: 10)
        }
    }
}
