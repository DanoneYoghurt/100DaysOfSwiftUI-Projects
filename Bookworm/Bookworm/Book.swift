//
//  Book.swift
//  Bookworm
//
//  Created by Антон Баскаков on 13.06.2024.
//

import SwiftData
import Foundation


@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date = Date.now.formatted(date: .abbreviated, time: .shortened)
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
