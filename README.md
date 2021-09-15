# Tutorial Base
> Personal collection of the various materials written by awesome experts.
>

## Fight against Massive View Controller 🥷🏼

### ⚙️ Coordinator

**Articles:**

1. Paul Hudson, [How to use the Coordinator pattern in iOS](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps).

**HOWTOs**

*Install*

1. Create a `Coordinator` class that contains an array of child coordinators and navigation controller property, as well as starting method that instantiate the 1st view controller in SceneDelegate (or AppDelegate). Use protocol for bigger apps.

```swift
// SceneDelegate
...
  let navigationContoller = UINavigationController()
  coordinator = MainCoordinator(navigationController: navigationContoller)
  coordinator?.start()
  window?.rootViewController = navigationContoller
  window?.makeKeyAndVisible()
...
```

2. To identify and instantiate view controllers in the coordinator use a protocol extension.

```swift
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
```

3. Create methods additionally to the starting method for each view controller transition that includes `pushViewController`.

```swift
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewContoller = ViewController.instantiate()
        viewContoller.coordinator = self
        navigationController.pushViewController(viewContoller, animated: false)
    }

    func buySubscription() {
        let viewController = BuyViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func createAccount() {
        let viewController = CreateAccountViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
```

</br>

*Move between controllers and pass data*

1. Use `coordinator's` method to move the required view controller.
```swift
@IBAction func createAccount(_ sender: Any) {
    coordinator?.createAccount()
}
```

2. Add data as a parameter to the method in the coordinator.
```swift
func buySubscription(to productType: Int) {
    let vc = BuyViewController.instantiate()
    vc.selectedProduct = productType
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
}
```

</br>

*Move back*

</br>

*Combine with TabBar*
