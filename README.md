# SwipeableCardView 

Customizable card views in Swift, with options to swipe left/right.

<img src="https://user-images.githubusercontent.com/33289471/81817941-0e5d7580-9536-11ea-800d-a9ba4d0b8342.gif" width="200" height="400" /> 

<!-- <img src="https://user-images.githubusercontent.com/33289471/81257738-b8239a80-903c-11ea-90b6-27a1f72a1d9e.gif" width="200" height="400" /> 
-->

# Installation

SwipeableCardView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwipeableCardView'
```

# Usage 🔨

Add `CardsContainer` to your view controller and set `delegate` and `dataSource` for it.

```
class ViewController: UIViewController {

    @IBOutlet weak var cardView: CardsContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
```

Conform your view controller to `CardsDataSource` protocol and override the methods.

```
extension ViewController: CardsDataSource {

    func numberOfCards() -> Int { 
       return yourData.count
    }
    
    func card(at index: Int) -> UIView {
        return CustomView()
    }
}
```

Conform your view controller to `CardsDelegate` protocol and override the methods.

```
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
        // TODO: Last card was removed from visible cards.
    }
}
```

# Properties

* The maximum number of cards that should be shown at the same time. The default value is 4.

```
var maximumVisibleCards: Int
```

* The object that acts as the data source of the cards view.

```
var dataSource: CardsDataSource?
```

* The object that acts as the delegate of the cards view.

```
var delegate: CardsDelegate?
```

# Methods

Reloads all of the items for the cards view.

```
public func reloadData()
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Neda Katalin

## License

SwipeableCardView is available under the MIT license. See the LICENSE file for more info.
