//
//  ItunesItem.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation

struct ItunesItem: Codable {
    var resultCount: Int = 0
    var results: [ItemResult] = []
}

// MARK: - ItemResult
struct ItemResult: Codable {
    let trackId: Int
    let trackName: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let primaryGenreName: String
    let trackPrice: Double
    let longDescription: String
    let currency: String
}
