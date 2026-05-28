//
//  AppDelegate.swift
//  sofascore2026
//
//  Created by akademija on 05.03.2026..
//
// Source - https://stackoverflow.com/a/68265172
// Posted by milczi
// Retrieved 2026-03-10, License - CC BY-SA 4.0


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        if AuthService.shared.isLoggedIn {
            window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        } else {
            window?.rootViewController = LoginViewController()
        }
        window?.makeKeyAndVisible()

        return true
    }

    static func showMain() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        let navController = UINavigationController(rootViewController: HomeViewController())
        UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
            appDelegate.window?.rootViewController = navController
        }
    }

    static func showLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        UIView.transition(with: window, duration: 0.35, options: .transitionCrossDissolve) {
            appDelegate.window?.rootViewController = LoginViewController()
        }
    }
}
