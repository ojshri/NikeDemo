//
//  AlbumsListViewModel.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import UIKit

protocol ViewModelDelegate {
    func didFetchData(withResults result: [Result])
    func didFailDataFetch()
}

enum SearchType {
    case Success
    case Failure
}

typealias AlbumsCompletion = (_ result: SearchType) -> Void
typealias ImageDownloadCompletion = (_ image: Data) -> Void

class AlbumsListViewModel {
    
    let vmDelegate: ViewModelDelegate!
    fileprivate var dataModel: TopAlbum?
    fileprivate var results: [Result]!
    
    init(withDelegate delegate: ViewModelDelegate){
        self.vmDelegate = delegate
    }
    
    func fetchData(){
        fetchTopAlbums { [unowned self] result in
            switch result {
            case .Success:
                self.vmDelegate.didFetchData(withResults: self.results)
            case .Failure:
                self.vmDelegate.didFailDataFetch()
            }
        }
    }
    
    private func fetchTopAlbums(withCompletion completion: @escaping AlbumsCompletion) {
        
        // Get the url
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/30/explicit.json"
        guard let url  = URL(string: urlString)
            else {
                completion(.Failure)
                return
        }
        
        RequestAdapter.request(withURL: url) { [unowned self] data in
            do{
                guard let data = data else {return}
                
                // Parse Json Data
                let response = try JSONDecoder().decode(TopAlbum.self, from: data)
                
                self.dataModel = response
                guard let results = response.feed?.results else {
                    
                    DispatchQueue.main.async {
                        // notify the closure about the search result on main thread
                        completion(.Failure)
                    }
                    return
                }
                self.results = results
                DispatchQueue.main.async {
                    // notify the closure about the search result on main thread
                    completion(results.count > 0 ? .Success : .Failure)
                }
                
            }catch{
                print(error)
            }
            
        }
        
    }
    
    func fetchAlbumImage(withURL urlString: String,
                         completion: @escaping ImageDownloadCompletion) {
        
        guard let url  = URL(string: urlString) else { return }
        
        RequestAdapter.request(withURL: url) { data in
            guard let data = data else {return}
            // Delegate the data to the view
            DispatchQueue.main.async {
                // return image downloaded Image on main thread
                completion(data)
            }
        }
    }
    
}
