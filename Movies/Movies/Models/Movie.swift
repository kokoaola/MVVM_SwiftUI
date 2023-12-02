//
//  Movie.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation

//ルートの構造
struct MovieResponse: Codable {
    //実際のJSONのキーはMovieと大文字から始まるけどSwiftでは実装できないので、下のCodingKeysを使用する
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

//映画一本の構造
struct Movie: Codable {
    //実際のJSONのキーはTitle、Year...と大文字から始まるけどSwiftでは実装できないので、下のCodingKeysを使用する
    let title: String
    let year: String
    let imdbId: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}


/*
 //ルートの要素であるSearchが存在しているパターン
 
 {
 "Search":[
 {
 "Title":"Kubi",
 "Year":"2023",
 //一意のID
 "imdbID":"tt27502365",
 "Type":"movie",
 "Poster":"https://m.media-amazon.com/images/M/MV5BNDYwMzg5YjMtMzA0Mi00OTMxLWFkZGQtM2YyZTc2NzQ4MjJhXkEyXkFqcGdeQXVyMTEzMTI1Mjk3._V1_SX300.jpg"
 },
 {
 "Title":"Kubi",
 "Year":"1968",
 "imdbID":"tt0293337",
 "Type":"movie",
 "Poster":"N/A"
 },
 {
 "Title":"Sochô no kubi",
 "Year":"1979",
 "imdbID":"tt0144614",
 "Type":"movie",
 "Poster":"https://m.media-amazon.com/images/M/MV5BYTJlOWUwMTYtNTQ4MS00NzJlLTg0MzAtOTU5MzY1ZWVhOWI3XkEyXkFqcGdeQXVyMTIxMDUyOTI@._V1_SX300.jpg"
 }
 ],
 "totalResults":"16",
 "Response":"True"
 }
 
 */
