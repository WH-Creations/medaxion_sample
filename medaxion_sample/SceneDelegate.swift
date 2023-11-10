//
//  SceneDelegate.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application(_:configurationForConnecting:options:)` instead).

        // Guard to ensure the scene is of type UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a UIWindow using the windowScene constructor which takes in a window scene.
        let window = UIWindow(windowScene: windowScene)
        
        // Check if the app is launched for the specific UI test
        if CommandLine.arguments.contains("--UITesting-HomeViewController") {
            // Configure with MockHomeViewModel and show HomeViewController
            let mockViewModel = MockHomeViewModel(characters: [
                MarvelCharacter(
                    id: 1,
                    name: "Iron Man",
                    description: "A wealthy industrialist and genius inventor",
                    resourceURI: nil,
                    thumbnail: MarvelCharacterThumbnail(path: "path/to/ironman", ext: "jpg"),
                    comics: nil,
                    stories: nil,
                    events: nil,
                    series: nil
                ),
                MarvelCharacter(
                    id: 2,
                    name: "Hulk",
                    description: "A green behemoth",
                    resourceURI: nil,
                    thumbnail: MarvelCharacterThumbnail(path: "path/to/hulk", ext: "jpg"),
                    comics: nil,
                    stories: nil,
                    events: nil,
                    series: nil
                )
            ])
            let homeViewController = HomeViewController(viewModel: mockViewModel, layout: UICollectionViewFlowLayout())
            
            // Set the LoginViewController as the root view controller
            window.rootViewController = UINavigationController(rootViewController: homeViewController)
            
            // Set the window and make it key and visible
            self.window = window
        } else {
            
            // Create the LoginViewModel
            let viewModel = LoginViewModel(authService: AuthenticationService())
            
            // Create the LoginViewController with the viewModel
            let loginViewController = LoginViewController(viewModel: viewModel)
            
            // Set the LoginViewController as the root view controller
            window.rootViewController = loginViewController
            
            // Set the window and make it key and visible
            self.window = window
        }
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

