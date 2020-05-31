//
//  ItuneItemDetailsViewController.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVMCore

final class ItuneItemDetailsViewController: UIViewController, ViewControllerModellable, ControllerModellable {
    
    typealias ViewModel = ItuneItemDetailsViewModel

    fileprivate struct LayoutConstraints {
        static let offset = UIOffset(horizontal: 20, vertical: 30)
    }
    
    // MARK: - Subviews -
    
    fileprivate let remoteCoverImage: RemoteUIImageView = {
        let view = RemoteUIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate let lblDescription: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkText
        return view
    }()
    
    fileprivate let btnCTA: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.setTitleColor(UIColor.white, for: .normal)
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
        navigationController?.isNavigationBarHidden = false
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
    }
    
    @objc func done() {
        viewModel.didTapDone()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    fileprivate func setUpViews() {
        view.addSubview(remoteCoverImage)
        view.addSubview(lblDescription)
        view.addSubview(btnCTA)
        NSLayoutConstraint.activate([
            remoteCoverImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: LayoutConstraints.offset.vertical),
            remoteCoverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remoteCoverImage.heightAnchor.constraint(equalToConstant: 300),
            remoteCoverImage.widthAnchor.constraint(equalToConstant: 300),
            
            lblDescription.topAnchor.constraint(equalTo: remoteCoverImage.bottomAnchor,
                                                constant: LayoutConstraints.offset.vertical),
            lblDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: LayoutConstraints.offset.horizontal),
            lblDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -LayoutConstraints.offset.horizontal),
            
            btnCTA.topAnchor.constraint(equalTo: lblDescription.bottomAnchor,
                                        constant: LayoutConstraints.offset.vertical),
            btnCTA.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: LayoutConstraints.offset.horizontal),
            btnCTA.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -LayoutConstraints.offset.horizontal),
            btnCTA.heightAnchor.constraint(equalToConstant: 44),
            btnCTA.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -LayoutConstraints.offset.vertical)
            
        ])
    }
    
    fileprivate func setUpModelObservables() {
        title = viewModel.itunesItem.trackName
        remoteCoverImage.load(url: viewModel.itunesItem.artworkUrl100)
        lblDescription.text = viewModel.itunesItem.longDescription
        
        viewModel.itemState
            .subscribe(onNext: { [weak self] state in
                if state {
                    self?.btnCTA.backgroundColor = UIColor.red
                    self?.btnCTA.setTitle("Remove from favorites", for: .normal)
                } else {
                    self?.btnCTA.backgroundColor = UIColor.green
                    self?.btnCTA.setTitle("Add to favorites", for: .normal)
                }
            }).disposed(by: disposeBag)
        
        btnCTA.rx.tap.bind { [weak self] in
            self?.viewModel.didTapCTA()
        }.disposed(by: disposeBag)
        
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            viewModel.dispose()
        }
    }
}

// MARK: - Extensions

extension ItuneItemDetailsViewController {
    
}
