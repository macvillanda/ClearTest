//
//  UserStorage.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation

struct UserStorage: PersistentStorable {
    
    static let favorites = "favorites"
    
    func getValue<T>(for key: String, defaultValue: T) -> T {
        return (UserDefaults.standard.value(forKey: key) as? T) ?? defaultValue
    }
    
    func setValue<T>(key: String, value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func hasValue(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) != nil
    }
}
