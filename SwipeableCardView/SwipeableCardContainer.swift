//
//  SwipeableCardContainer.swift
//  SwipeableCardView
//
//  Created by Katalin Neda on 13/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

public protocol CardsDataSource {
    /**
       Tells the data source to return the number of cards.
     */
    func numberOfCards() -> Int
    /**
        Tells the data source to insert the card in a particular location.
     */
    func card(at index: Int) -> UIView
}

public protocol CardsDelegate {
    /**
     Tells the delegate that the specified card is swiped left.
     */
    func didSwipeLeft(at index: Int)
    /**
        Tells the delegate that the specified card is swiped right.
    */
    func didSwipeRight(at index: Int)
    /**
        Tells the delegate that the specified card is selected.
    */
    func didSelectCard(at index: Int)
    /**
        Tells the delegate that the last card was removed from the visible cards.
     */
    func didRemoveLastCard()
}

public class SwipeableCardsContainer: UIView {
    
    // MARK: - Properties
    
    /**
        The maximum number of cards that should be shown at the same time.
     */
    public var maximumVisibleCards: Int = 4
    
    /**
        The object that acts as the data source of the cards view.
     */
    public var dataSource: CardsDataSource? {
        didSet {
            reloadData()
        }
    }
    /**
       The object that acts as the delegate of the cards view.
    */
    public var delegate: CardsDelegate?
    
    // MARK: - Private properties
    
    private var numberOfCards = 0
    private var visibleCards: [SwipeableCard] = []
    private var cards: [SwipeableCard] = []
    private var padding: CGFloat = 10
    private var cardHeight: CGFloat = 0
    
    private var leftCards = 0
        
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        cardHeight = frame.height - CGFloat(maximumVisibleCards * 10)
        rearrange()
    }
    
    // MARK: - Public methods
    
    /**
     Reloads all of the data for the cards view.
     */
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
        let card = SwipeableCard(content: view)
        card.delegate = self
        visibleCards.append(card)
        cards.append(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(card, at: 0)
    }
    
    private func removeAll() {
        for card in visibleCards {
            card.removeFromSuperview()
        }
        visibleCards = []
    }
    
    private func rearrange() {
        for index in 0..<visibleCards.count {
            if (index == 0) {
                visibleCards[index].removeOverlay()
            }
            visibleCards[index].addTopAnchor(related: self, constant: CGFloat(index) * padding)
            visibleCards[index].addHeightAnchor(constant: cardHeight)
            visibleCards[index].addLeadingAnchor(related: self, constant: 10)
            visibleCards[index].addTrailingAnchor(related: self, constant: 10)
        }
    }
}

// MARL: - CardDelegate

extension SwipeableCardsContainer: SwipeableCardDelegate {

    public func didRemoveCard(_ card: SwipeableCard) {

        visibleCards.remove(at: 0)
        card.removeFromSuperview()

        guard let dataSource = dataSource else { return }
        
        if leftCards != 0 {
            let startIndex = numberOfCards - leftCards
            
            let contentView = dataSource.card(at: startIndex)
            createCard(from: contentView, at: maximumVisibleCards)
            
            leftCards -= 1
        }
        
        if visibleCards.count == 0 {
            delegate?.didRemoveLastCard()
        }
        
        rearrange()
    }
    
    public func didSwipeLeft(_ card: SwipeableCard) {
        guard let index = cards.firstIndex(where: { $0 == card}) else { return }
        delegate?.didSwipeLeft(at: index)
    }
    
    public func didSwipeRight(_ card: SwipeableCard) {
        guard let index = cards.firstIndex(where: { $0 == card}) else { return }
        delegate?.didSwipeRight(at: index)
    }
    
    public func didTapOnCard(_ card: SwipeableCard) {
        guard let index = cards.firstIndex(where: { $0 == card}) else { return }
        delegate?.didSelectCard(at: index)
    }
}
