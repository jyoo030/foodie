//
//  SceneDelegate.swift
//  foodie
//
//  Created by Justin Yoo on 3/16/20.
//  Copyright © 2020 Joftware. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var userDefaultsManager = UserDefaultsManager()
    var groupManager = GroupManager()
    var notificationManager = NotificationManager()
    var loginManager = LoginManager()
    lazy var restaurantManager = RestaurantManager(userDefaultsManager: userDefaultsManager, groupManager: groupManager)
    lazy var userManager = UserManager(userDefaultsManager: userDefaultsManager)
    lazy var socket = Socket(userDefaultsManager: userDefaultsManager, notificationManager: notificationManager, userManager: userManager)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().onAppear(perform: {
            if !self.userDefaultsManager.userId.isEmpty {
                self.userManager.getUser(id: self.userDefaultsManager.userId, onComplete: {
                    self.notificationManager.getNotifications(userId: self.userDefaultsManager.userId)
                    self.socket.establishConnection()
 
                    if !self.userDefaultsManager.currentGroup.id.isEmpty {
                        self.restaurantManager.getRestaurantsByRadius(radius: self.userDefaultsManager.currentGroup.radius, location: self.userDefaultsManager.currentGroup.location, offset: self.userDefaultsManager.currentGroup.offsets[self.userDefaultsManager.userId])
                    }
                })
            }
        })
            .environmentObject(restaurantManager)
            .environmentObject(userDefaultsManager)
            .environmentObject(loginManager)
            .environmentObject(userManager)
            .environmentObject(groupManager)
            .environmentObject(notificationManager)
            .environmentObject(socket)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

