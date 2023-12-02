//
//  URL+Extensions.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation

///検索項目とAPIキーからURLを生成する拡張機能
extension URL {
    
    static func forMoviesByName(_ name: String) -> URL? {
        return URL(string: "http://www.omdbapi.com/?s=\(name)&apikey=\(Constants.API_KEY)")
    }
    
}
