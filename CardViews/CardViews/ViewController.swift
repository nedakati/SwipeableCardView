//
//  ViewController.swift
//  CardViews
//
//  Created by Katalin Neda on 03/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    var cardView: CardsContainer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }

    // MARK: - Private properties
    
    private func addViews() {
        cardView = CardsContainer()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.dataSource = self
        
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - CardsDataSource

extension ViewController: CardsDataSource {

    func numberOfCards() -> Int { 10 }
    
    func card(at index: Int) -> UIView {
        let view = UILabel()
        view.text = "\(index)"
        view.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        return view
    }
}

