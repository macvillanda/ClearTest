//
//  ItunesItemCell.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import UIKit

final class ItunesItemCell: UITableViewCell {

    private let margin: CGFloat = 10
    static let identifier = "ItunesItemCell"
    let remoteImage: RemoteUIImageView = {
        let view = RemoteUIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let lblTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textColor = UIColor.black
        return view
    }()
    
    let lblSubTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkText
        return view
    }()
    
    let lblBotText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkText
        return view
    }()
    
    let imgfavorite: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "ic_star")
        view.isHidden = true
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        remoteImage.cancelTask()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func setUp() {
        
        contentView.addSubview(remoteImage)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblSubTitle)
        contentView.addSubview(lblBotText)
        contentView.addSubview(imgfavorite)
        
        NSLayoutConstraint.activate([
            remoteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            remoteImage.heightAnchor.constraint(equalToConstant: 50),
            remoteImage.widthAnchor.constraint(equalToConstant: 50),
            remoteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            lblTitle.leadingAnchor.constraint(equalTo: remoteImage.trailingAnchor, constant: margin),
            lblTitle.trailingAnchor.constraint(equalTo: imgfavorite.leadingAnchor, constant: -margin),
            
            lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: margin),
            lblSubTitle.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblSubTitle.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            
            lblBotText.topAnchor.constraint(equalTo: lblSubTitle.bottomAnchor, constant: margin),
            lblBotText.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblBotText.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            lblBotText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            
            imgfavorite.heightAnchor.constraint(equalToConstant: 32),
            imgfavorite.widthAnchor.constraint(equalToConstant: 32),
            imgfavorite.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imgfavorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
            
        ])
    }

}
