//
//  ViewController.swift
//  SwipeableCardViewExample
//
//  Created by Katalin Neda on 13/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit
import SwipeableCardView

class ViewController: UIViewController {

    // MARK: - Properties
    
    var cardView: SwipeableCardsContainer!
    var viewModel = ViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }

    // MARK: - Private properties
    
    private func addViews() {
        cardView = SwipeableCardsContainer()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.dataSource = self
        cardView.delegate = self
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: title.font.fontName, size: 50)
        title.text = "Explore"
        
        view.addSubview(title)
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            cardView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.8)
        ])
    }
}

// MARK: - CardsDataSource

extension ViewController: CardsDataSource {

    func numberOfCards() -> Int { viewModel.cities.count }
    
    func card(at index: Int) -> UIView {
        let view = CustomView()
        view.addContent(image: viewModel.cities[index].image, title: viewModel.cities[index].title)
        return view
    }
}

// MARK: - CardsDelegate

extension ViewController: CardsDelegate {

    func didSwipeLeft(at index: Int) {
        // TODO: Handle swipe action
    }
    
    func didSwipeRight(at index: Int) {
        // TODO: Handle swipe action
    }
    
    func didSelectCard(at index: Int) {
        // TODO: Handle action
    }
    
    func didRemoveLastCard() {
        cardView.reloadData()
    }
}


