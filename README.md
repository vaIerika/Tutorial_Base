# Tutorial Base
> Personal collection of the various materials written by awesome experts.
>

## Fight against Massive View Controller 🥷🏼

### ⚙️ Coordinator

**Articles:**

1. Paul Hudson, [How to use the Coordinator pattern in iOS](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps).
2. Paul Hudson, [Advanced coordinators in iOS](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios).

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

*Use several coordinators*

1. Add new coordinator classes, conformed to `Coordinator` protocol.

2. Move the implementation of the method from that instantiate required view controller from the main coordinator to the new one as a starting method, change type of coordinator for that view controller.

3. Add to the main coordinator a new coordinator as a child.

```swift
func buySubscription() {
    let child = BuyCoordinator(navigationController: navigationController)
    childCoordinators.append(child)
    child.start()
}
```

</br>

*Move back*

 - Option 1 for simple projects.

 1. Check if the view controller is disappear with the `viewWillDisappear` method, call a function `coordinator.didFinishBuying()` of the coordinator.

 2. Child coordinator calls a parent method `parentCoordinator?.childDidFinish(self)`, sending itself. The `parentCoordinator` has to be `weak` optional.

 3. Main coordinator removes that child from the `childCoordinators`. Coordinator must to be conform to AnyObject (so it cannot be a struct).
 ```swift
 func childDidFinish(_ child: Coordinator?) {
     for (index, coordinator) in childCoordinators.enumerated() {
         if coordinator === child {
             childCoordinators.remove(at: index)
             break
         }
     }
 }
 ```

 - Option 2 for more complicated projects.

 1. Conform the main coordinator to the `UINavigationControllerDelegate` protocol, as well as to inherit from `NSObject`. Add a delegate to the starting method: `navigationController.delegate = self `.

 2. Add a method in the main coordinator to move back.
 ```swift
 func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
     guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {  return }

     // pushing vc on the top rather than popping it
     if navigationController.viewControllers.contains(fromViewController) {
         return
     }

     // popping vc, typecasting
     if let buyViewController = fromViewController as? BuyViewController {
         childDidFinish(buyViewController.coordinator)
     }
 }
```

</br>

*Combine with TabBar*

1. Create a main TabBarController with properties for the each of the coordinators that are used inside its tabs.

2. Instantiate view controllers with calling starting methods of the coordinators and appending their navigation controllers in `MainTabBarController`.
```swift
class MainTabBarController: UITabBarController {

    /// tabs
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    let historyCoordinator = HistoryCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        mainCoordinator.start()
        historyCoordinator.start()
        viewControllers = [mainCoordinator.navigationController, historyCoordinator.navigationController]    /// has to have TabBarItems
    }
}
```

3. Give each coordinator a tab bar item in a starting method: `viewContoller.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)`.

4. Change the root view controller with the created TabBarController: ` window?.rootViewController = MainTabBarController()`.
Attemp 2signatures 
</br>
