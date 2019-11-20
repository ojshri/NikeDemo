//
//  AlbumDetailsViewController.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    fileprivate let albumArtView: UIImageView = UIImageView()
    fileprivate let albumLabel: UILabel = UILabel()
    fileprivate let artistLabel: UILabel = UILabel()
    fileprivate let genreLabel: UILabel = UILabel()
    fileprivate let releaseInfoLabel: UILabel = UILabel()
    fileprivate let copyrightLabel: UILabel = UILabel()
    fileprivate let iTunesButton: UIButton = UIButton()
    
    var albumData: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        iTunesButtonSetUp()
        udpateViews()
    }
    
    func udpateViews() {
        albumLabel.text = albumData.collectionName
        artistLabel.text = albumData.artistName
        
        if let genres = albumData.genres?.map({ (genre) -> String in
            guard let name = genre.name else { return "" }
            return name
        }){
            genreLabel.text = genres.joined(separator: " ")
        }
        releaseInfoLabel.text = albumData.releaseDate
        copyrightLabel.text = albumData.copyright
        
        guard let image = UIImage(data: albumData.image ?? Data()) else{ return }
        albumArtView.image = image
    }
}


extension AlbumDetailsViewController {
    
    func setupViews() {
        
        albumArtView.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // add views
        view.addSubview(albumArtView)
        view.addSubview(albumLabel)
        view.addSubview(artistLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseInfoLabel)
        view.addSubview(copyrightLabel)
        view.addSubview(iTunesButton)
        
        // setup view properties
        albumArtView.contentMode = .scaleAspectFit
        albumLabel.font = .boldSystemFont(ofSize: 17)
        artistLabel.font = .systemFont(ofSize: 17)
        genreLabel.font = .systemFont(ofSize: 15)
        releaseInfoLabel.font = .systemFont(ofSize: 14)
        copyrightLabel.font = .systemFont(ofSize: 13)
        
        albumLabel.textColor = .black
        artistLabel.textColor = .red
        genreLabel.textColor = .darkGray
        releaseInfoLabel.textColor = .darkGray
        copyrightLabel.textColor = .lightGray
        copyrightLabel.numberOfLines = 0
        
        let marginGuide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            // album art view
            albumArtView.heightAnchor.constraint(equalToConstant: 360),
            albumArtView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            albumArtView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            albumArtView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20),
            
            // album label
            albumLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            albumLabel.topAnchor.constraint(equalTo: albumArtView.bottomAnchor, constant: 30),
            
            // artist label
            artistLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            artistLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 12),
            
            // genre label
            genreLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            genreLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 12),
            
            // release label
            releaseInfoLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            releaseInfoLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 12),
            
            // copyright label
            copyrightLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            copyrightLabel.topAnchor.constraint(equalTo: releaseInfoLabel.bottomAnchor, constant: 12),
            copyrightLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            // iTunes button
            // iTunesButton.heightAnchor.constraint(equalToConstant: 60),
            // iTunesButton.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            // iTunesButton.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            // iTunesButton.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 20)
            ])
    }
    
    
    func iTunesButtonSetUp() {
        
        iTunesButton.layer.cornerRadius = 10
        iTunesButton.backgroundColor = .init(red: 0, green: 0.467, blue: 0.784, alpha: 1)
        iTunesButton.setTitleColor(.white, for: .normal)
        iTunesButton.center.x = view.center.x
        
        iTunesButton.frame = CGRect(x: 20,
                                    y: view.frame.height - 80,
                                    width: view.frame.width - 40,
                                    height: 60)
        
        iTunesButton.setTitle("Play on  Music", for: .normal)
        iTunesButton.addTarget(self,
                               action: #selector(goToITunesPage(_:)),
                               for: .touchUpInside)
    }
    
    @objc func goToITunesPage(_ sender: Any) {
        if let url = URL(string: albumData.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
}
