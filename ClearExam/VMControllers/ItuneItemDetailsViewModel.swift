//
//  ItuneItemDetailsViewModel.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import RxSwift
import MVVMCore

final class ItuneItemDetailsViewModel: CoordinatedInitiable {
    
    weak var coordinateDelegate: CoordinatorDelegate?
    var disposeBag = DisposeBag()
    // MARK: - Observable vars
    let itunesItem: ItemResult
    let itemState = BehaviorSubject(value: false)
    required init(model: Any?) {
        guard let item = model as? ItemResult else {
            fatalError("ItemResult must be provided")
        }
        itunesItem = item
        itemState.onNext(UserCache.shared.isFavorite(id: itunesItem.trackId))
    }
    
    func didTapCTA() {
        if UserCache.shared.isFavorite(id: itunesItem.trackId) {
            UserCache.shared.removeFavorite(id: itunesItem.trackId)
            itemState.onNext(false)
        } else {
            UserCache.shared.addFavorite(id: itunesItem.trackId)
            itemState.onNext(true)
        }
    }
    
    func didTapDone() {
        coordinateDelegate?.dismissPresented()
    }
}
