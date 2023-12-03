//
//  MovieListViewModel.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation
import SwiftUI

///映画のリストを管理するViewModel
///ViewModelBase（検索結果の管理用のビューモデル）がすでにObservableobjectを実装しているため、Observableobjectはへの準拠は不要
class MovieListViewModel: ViewModelBase{

    ///ビューが観察できる映画データの配列
    @Published var movies = [MovieViewModel]()
    
    ///HTTP通信を行うクライアント
    let httpClient = HTTPClient()

    ///名前で映画を検索する関数
    func searchByName(_ name: String) {
        //検索文字列が空の場合は何もしない
        if name.isEmpty {
            return
        }

//        //ローディング状態を開始
        self.loadingState = .loading

        //HTTPクライアントを使用して映画を検索
        //スペースを%20に置き換える
        httpClient.getMoviesBy(search: name.trimmedAndEscaped()) { result in
            switch result {
            case .success(let movies):
                //成功した場合はムービー配列を1つずつマッピングし、映画データに変換（イニシャライズ）
                if let movies = movies {
                    DispatchQueue.main.async {
                        self.movies = movies.map(MovieViewModel.init)
                        self.loadingState = .success
                    }
                }
            case .failure(let error):
                //エラー時はコンソールにエラーを表示し、メインスレッドで失敗状態に更新
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
            }
        }
    }
}

///ビューにモデルのデータを提供して、表示できるようにするViewModel
struct MovieViewModel {
    
    ///映画データ
    let movie: Movie
    
    ///IMDb ID
    var imdbId: String {
        movie.imdbId
    }
    
    ///タイトル
    var title: String {
        movie.title
    }
    
    ///ポスター画像URL
    var poster: String {
        movie.poster
    }
    
    ///公開年
    var year: String {
        movie.year
    }
}
