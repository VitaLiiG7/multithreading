
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createRootViewController(windowScene)
    }

    private func createRootViewController(_ windowScene: UIWindowScene) {
        let mainViewController = ViewControllerThirteenthTask4()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }
}

