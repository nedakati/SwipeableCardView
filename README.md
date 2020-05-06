# CardView



# Usage

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


