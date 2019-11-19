//
//  AlbumsListDataModel.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import Foundation

// MARK: - TopAlbum
class TopAlbum: Decodable {
    let feed: Feed?
}


// MARK: - Feed
class Feed: Decodable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright: String?
    let country: String?
    let icon: String?
    let updated: String?
    let results: [Result]?
}


// MARK: - Author
class Author: Decodable {
    let name: String?
    let uri: String?
}


// MARK: - Link
class Link: Decodable {
    let linkSelf: String?
    let alternate: String?
}


// MARK: - Result
class Result: Decodable {
    let artistName: String?
    let id: String?
    let releaseDate: String?
    let name: String?
    let collectionName: String?
    let kind: String?
    let copyright: String?
    let artistID: String?
    let contentAdvisoryRating: String?
    let artistURL: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
    var image: Data?
}


// MARK: - Genre
class Genre: Decodable {
    let genreID: String?
    let name: String?
    let url: String?
}

