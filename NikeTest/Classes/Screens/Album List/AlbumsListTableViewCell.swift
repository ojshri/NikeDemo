//
//  AlbumsListTableViewCell.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import UIKit

protocol AlbumCellDataSource {
    func fetchImage(forResult result: Result,
                    completion: @escaping ImageDownloadCompletion)
}

class AlbumsListTableViewCell: UITableViewCell {
    static let identifier = "albumsCell"
    
    fileprivate let artistLabel: UILabel = UILabel()
    fileprivate let albumLabel: UILabel = UILabel()
    fileprivate let thumbnailView: UIImageView = UIImageView()
    fileprivate let loading: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        isUserInteractionEnabled = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func configureCell(withData data: Result,
                       forDataSource dataSource: AlbumCellDataSource) {
        
        artistLabel.text = data.artistName
        albumLabel.text = data.collectionName
        loading.startAnimating()
        dataSource.fetchImage(forResult: data) { [weak self] image in
            self?.loading.stopAnimating()
            guard let image = UIImage(data: image) else{ return }
            self?.thumbnailView.image = image
        }
    }
    
    func configureCellWithoutData() {
        artistLabel.text = "Data Not Available"
        albumLabel.text = "Data Not Available"
    }
}

extension AlbumsListTableViewCell {
    
    func setupViews() {
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        // Add views
        contentView.addSubview(artistLabel)
        contentView.addSubview(albumLabel)
        contentView.addSubview(thumbnailView)
        contentView.addSubview(loading)
        
        // Setup View Properties
        thumbnailView.contentMode = .scaleAspectFit
        artistLabel.font = .boldSystemFont(ofSize: 17.0)
        artistLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        albumLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        albumLabel.textColor = .darkGray
        artistLabel.numberOfLines = 0
        albumLabel.numberOfLines = 0
        
        // Setup Views Constraints
        let marginGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            // album Art
            thumbnailView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailView.heightAnchor.constraint(equalToConstant: 120),
            thumbnailView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            thumbnailView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            thumbnailView.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor),
            
            // artist label
            artistLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            artistLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            // album Label
            albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8),
            albumLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            albumLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            ])
    }
}
