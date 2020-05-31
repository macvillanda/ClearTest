//
//  PersistentStorable.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation

protocol PersistentStorable {
    func getValue<T>(`for` key: String, defaultValue: T) -> T
    func setValue<T>(key: String, value: T)
    func hasValue(key: String) -> Bool
}
