//
//  ItuneListViewController.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVMCore

final class ItuneListViewController: UIViewController, ViewControllerModellable, ControllerModellable {
    
    typealias ViewModel = ItuneListViewModel

    fileprivate struct LayoutConstraints {
        // Put static constants for layouts here
    }
    
    // MARK: - Subviews -
    
    fileprivate let table: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 80.0
        view.backgroundColor = .white
        view.separatorStyle = .singleLine
        view.register(ItunesItemCell.self, forCellReuseIdentifier: ItunesItemCell.identifier)
        return view
    }()
    
    fileprivate let loader: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.isLoading = false
        return view
    }()
    
    // MARK: - Properties
    let coordinatedModel: CoordinatedInitiable
    fileprivate let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - View lifecycle
    
    required init(model: ViewModel) {
        self.viewModel = model
        self.coordinatedModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpViews()
        setUpModelObservables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.request()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.largeTitleDisplayMode = .always
    }
    
    fileprivate func setUpViews() {
        
        view.addSubview(table)
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loader.topAnchor.constraint(equalTo: view.topAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    fileprivate func setUpModelObservables() {
        
        viewModel.content.asObservable()
        .flatMap{ [weak self] items -> Observable<[ViewModel.SearchItem]> in
            self?.table.tableFooterView?.isHidden = items.count == 0
            return Observable.just(items)
        }.bind(to: table.rx.items(cellIdentifier: ItunesItemCell.identifier, cellType: ItunesItemCell.self)) { [weak self] (row, item, cell) in
            
            cell.lblTitle.text = item.trackName
            cell.lblSubTitle.text = item.genre
            cell.lblBotText.text = item.price
            cell.remoteImage.load(url: item.artwork)
            cell.imgfavorite.isHidden = !UserCache.shared.isFavorite(id: item.trackID)
            
            if let items = self?.viewModel.content.value {
                if row == items.count - 1 && items.count >= 10 {
                    self?.loadNext()
                    self?.viewModel.request(getNext: true)
                } else {
                    self?.table.tableFooterView?.isHidden = false
                }
            }
        }.disposed(by: disposeBag)
        
        table.rx.didEndDisplayingCell
        .subscribe(onNext: { (cell, path) in
            if let itemCell = cell as? ItunesItemCell {
                itemCell.remoteImage.cancelTask()
            }
        }).disposed(by: disposeBag)
        
        viewModel.networkSubject
            .subscribe(onNext: { [weak self] netState in
                switch netState {
                case .loading:
                    if self?.viewModel.content.value.isEmpty ?? false {
                        self?.loader.isLoading = true
                    }
                default:
                    self?.loader.isLoading = false
                }
            }).disposed(by: disposeBag)
        
        table.rx.itemSelected
            .subscribe(onNext: { [weak self] path in
                self?.viewModel.didSelectItem(index: path.row)
            }).disposed(by: disposeBag)
        
    }
    
    fileprivate func loadNext() {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: table.bounds.width, height: CGFloat(44))

        table.tableFooterView = spinner
        table.tableFooterView?.isHidden = false
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            viewModel.dispose()
        }
    }
}

// MARK: - Extensions

extension ItuneListViewController {
    
}
