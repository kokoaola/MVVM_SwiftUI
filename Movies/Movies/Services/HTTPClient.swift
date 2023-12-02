//
//  HTTPClient.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation



///エラータイプを定義する列挙型、Errorプロトコルに準拠
enum NetworkError: Error {
    case badURL //URLが無効な場合のエラー
    case noData //データがない場合のエラー
    case decodingError //デコード中にエラーが発生した場合
}

///HTTPクライアントを表すクラス、Web APIからデータを取得する
class HTTPClient {
    
    ///映画情報を検索して取得するメソッド
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie]?,NetworkError>) -> Void) {
        
//        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=\(Constants.API_KEY)") else{
//            return completion(.failure(.badURL))
//        }
        
        
        //検索文字列に基づいてURLを生成し、無効な場合はエラーを返す
        guard let url = URL.forMoviesByName(search) else {
            return completion(.failure(.badURL))
        }

        //URLSessionを使用してデータタスクを作成し実行
        URLSession.shared.dataTask(with: url) { data, response, error in

            //データが存在しないかエラーがある場合はnoDataエラーを返す
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }

            //取得したデータをJSONデコードし、失敗した場合はdecodingErrorを返す
            ///ルートの要素であるSearchがあるため、[Movie]とはならない
            guard let moviesResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
                return completion(.failure(.decodingError))
            }

            //成功した場合は映画リストを返す
            completion(.success(moviesResponse.movies))

        }.resume() //データタスクを開始
    }
}
