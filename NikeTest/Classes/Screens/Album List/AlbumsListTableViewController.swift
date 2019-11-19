//
//  AlbumsListViewController.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import UIKit

class AlbumsListViewController: UIViewController {
    
    fileprivate var results: [Result]?
    fileprivate var viewModel: AlbumsListViewModel!
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel = AlbumsListViewModel(withDelegate: self)
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
}

extension AlbumsListViewController {
    
    func setupViews() {
        
        title = "Top Albums"
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        
        tableView.register(AlbumsListTableViewCell.self,
                           forCellReuseIdentifier: AlbumsListTableViewCell.identifier)
    }
}

extension AlbumsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsListTableViewCell.identifier,
                                                 for: indexPath) as! AlbumsListTableViewCell
        
        if let result = self.results?[indexPath.row] {
            cell.configureCell(withData: result, forDataSource: self)
        }
        else {
            cell.configureCellWithoutData()
        }
        
        return cell
    }
}

extension AlbumsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let viewController = AlbumDetailsViewController()
        viewController.albumData = self.results?[indexPath.row]
        show(viewController, sender: nil)
    }
}

extension AlbumsListViewController: ViewModelDelegate {
    
    func didFetchData(withResults result: [Result]) {
        self.results = result
        tableView.reloadData()
    }
    
    func didFailDataFetch() {
        // show error
    }
}

extension AlbumsListViewController: AlbumCellDataSource {
    func fetchImage(forResult result: Result,
                    completion: @escaping ImageDownloadCompletion) {
        self.viewModel.fetchAlbumImage(withURL: result.artworkUrl100 ?? "") { imageData in
            result.image = imageData
            completion(imageData)
        }
    }
}
