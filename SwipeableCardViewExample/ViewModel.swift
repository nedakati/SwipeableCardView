//
//  ViewModel.swift
//  SwipeableCardViewExample
//
//  Created by Katalin Neda on 13/05/2020.
//  Copyright © 2020 Katalin Neda. All rights reserved.
//

import UIKit

struct City {
    let image: UIImage?
    let title: String
}

class ViewModel {
    
    var cities: [City] = []
    
    init() {
        cities.append(City(image: UIImage(named: "amsterdam"), title: "Amsterdam"))
        cities.append(City(image: UIImage(named: "paris"), title: "Paris"))
        cities.append(City(image: UIImage(named: "switzerland"), title: "Switzerland"))
        cities.append(City(image: UIImage(named: "london"), title: "London"))
    }
    
}
