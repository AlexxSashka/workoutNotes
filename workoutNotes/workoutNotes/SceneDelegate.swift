//
//  SceneDelegate.swift
//  workoutNotes
//
//  Created by Gryaznoy Alexander on 15.10.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("It was not possible to get AppDelegate")
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainTabBarController(modelContext: appDelegate.modelContext)
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

