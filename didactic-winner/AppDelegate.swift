//
//  AppDelegate.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let imageStore: ImageStore = .init()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let backgroundColor: UIColor = UIColor.color(hex: "#F9F9F9")
        UINavigationBar.appearance().backgroundColor = backgroundColor
        UINavigationBar.appearance().setBackgroundImage(UIImage(color: backgroundColor), for: .default)
        return true
    }
}
