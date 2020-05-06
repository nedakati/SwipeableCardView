//
//  ViewModel.swift
//  CardViews
//
//  Created by Katalin Neda on 06/05/2020.
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
        cities.append(City(image: UIImage(named: "barcelona"), title: "Barcelona"))
        cities.append(City(image: UIImage(named: "mountain"), title: "Austria"))
        cities.append(City(image: UIImage(named: "paris"), title: "Paris"))
        cities.append(City(image: UIImage(named: "svajc"), title: "Switzerland"))
        cities.append(City(image: UIImage(named: "london"), title: "London"))
    }
    
}
