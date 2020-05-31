//
//  MainScreens.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation
import MVVMCore

enum MainScreens: ScreenCoordinated {

    case list
    case details(ItemResult)
    
    var tabItem: UITabBarItem? {
        return nil
    }
    
    var title: String? {
        switch self {
        case .list:
            return "STAR"
        case .details(let item):
            return item.trackName
        }
    }
    
    var tabTitle: String? {
        return nil
    }
    
    var configuration: ControllerConfiguration {
        var config = ControllerConfiguration()
        config.isNavHidden = false
        return config
    }
    
    var controllerModel: ControllerModel {
        switch self {
        case .list:
            return build(ItuneListViewController.self, modelType: ItuneListViewModel.self)
        case .details(let item):
            return build(ItuneItemDetailsViewController.self,
                         modelType: ItuneItemDetailsViewModel.self,
                         object: item)
        }
    }
}
