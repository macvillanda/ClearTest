//
//  ItuneListViewModel.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import RxSwift
import MVVMCore
import RxCocoa

final class ItuneListViewModel: CoordinatedInitiable {
    
    struct SearchItem {
        let artwork: String
        let trackName: String
        let price: String
        let genre: String
        let trackID: Int
    }
    
    enum NetworkState {
        case idle
        case loading
        case finish
        case error
    }
    
    let content = BehaviorRelay<[SearchItem]>(value: [])
    let networkSubject = BehaviorSubject(value: NetworkState.idle)
    weak var coordinateDelegate: CoordinatorDelegate?
    var disposeBag = DisposeBag()
    fileprivate var isLoading: Bool = false
    fileprivate var rawItems: [ItemResult] = []
    // MARK: - Observable vars
    
    required init(model: Any?) {
    }
    
    func request(getNext: Bool = false) {
        if isLoading {
            return
        }
        isLoading = true
        if !getNext && !content.value.isEmpty {
            let contentItems = content.value
            content.accept(contentItems)
            isLoading = false
            return
        }
        let offset = content.value.count
        networkSubject.onNext(NetworkState.loading)
        ItunesWebservice.search(offset: offset).request()
            .subscribe(onSuccess: { [weak self] (items: ItunesItem) in
                var contentItems = self?.content.value ?? []
                self?.rawItems.append(contentsOf: items.results)
                /*
                  use url60 for efficiency..
                  change to url100 if needed
                 */
                let newItems = items.results.map { SearchItem(artwork: $0.artworkUrl60,
                                                                trackName: $0.trackName,
                                                                price: "\($0.currency)\($0.trackPrice)",
                genre: $0.primaryGenreName, trackID: $0.trackId) }
                contentItems.append(contentsOf: newItems)
                self?.content.accept(contentItems)
                self?.isLoading = false
                self?.networkSubject.onNext(NetworkState.finish)
            }, onError: { [weak self] error in
                print("Error: \(error)")
                self?.isLoading = false
                self?.networkSubject.onNext(NetworkState.error)
            }).disposed(by: disposeBag)
    }
    
    func didSelectItem(index: Int) {
        let item = rawItems[index]
        let nav = UINavigationController()
        nav.navigationBar.barStyle = .black
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.isOpaque = true
        nav.navigationBar.prefersLargeTitles = true
        _ = coordinateDelegate?.present(screen: MainScreens.details(item),
                                        navigation: nav)
    }
}
