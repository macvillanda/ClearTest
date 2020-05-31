//
//  LoaderView.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import UIKit

final class LoaderView: UIView {

    fileprivate let loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                loader.startAnimating()
                isHidden = false
            } else {
                loader.stopAnimating()
                isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUp() {
        addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

}
