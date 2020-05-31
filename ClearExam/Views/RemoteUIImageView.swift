//
//  RemoteUIImageView.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol ContentDownloadable {
    func load(url: String)
    func cancelTask()
}

protocol RemoteImageContainer {
    var remoteImageView: RemoteUIImageView { get }
    func load(url: String)
}

final class RemoteUIImageView: UIImageView, ContentDownloadable {
    fileprivate var downloadTask: DownloadTask?
    func load(url: String) {
        downloadTask?.cancel()
        if let imageUrl = URL(string: url) {
            self.kf.indicatorType = .activity
            downloadTask = self.kf.setImage(with: imageUrl)
        }
    }
    
    func cancelTask() {
        downloadTask?.cancel()
    }
}
