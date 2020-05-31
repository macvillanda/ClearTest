//
//  UserCache.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation

final class UserCache {
    static let shared = UserCache()
    private init() {
    }
    var favorites: Set<Int> = Set()
    
    func loadFavorites() {
       let savedFavorites = UserStorage().getValue(for: UserStorage.favorites, defaultValue: [Int]())
       favorites = Set(savedFavorites)
    }
    func removeFavorite(id: Int) {
        favorites.remove(id)
        saveFavorites()
    }
    func addFavorite(id: Int) {
        favorites.insert(id)
        saveFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
        return favorites.contains(id)
    }
    
    private func saveFavorites() {
        let newFavorites = Array(favorites)
        UserStorage().setValue(key: UserStorage.favorites, value: newFavorites)
    }
}
