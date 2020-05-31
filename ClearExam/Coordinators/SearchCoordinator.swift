//
//  SearchCoordinator.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation
import UIKit
import MVVMCore

final class SearchCoordinator: Coordinator {
    fileprivate let window: UIWindow?
    @discardableResult
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let nav = UINavigationController()
        nav.navigationBar.barStyle = .black
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.isOpaque = true
        nav.navigationBar.prefersLargeTitles = true
        let startController = ViewCoordinator(singleScreen: MainScreens.list, navController: nav)
        self.window?.rootViewController = startController.navController
    }
}
