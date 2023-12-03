//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by koala panda on 2023/12/03.
//

import Foundation

/// 映画の詳細情報を扱うビューモデルクラス
class MovieDetailViewModel: ObservableObject {
    
    //実際のモデルが存在しない場合もあるのでオプショナルにする
    private var movieDetail: MovieDetail?
    
    //ロード状態を保持
    @Published var loadingState = LoadingState.loading
    
    // HTTP通信を担当するクライアント
    private var httpClient = HTTPClient()
    
    // 初期化メソッド、映画の詳細情報をオプションで受け取り、何も渡されない場合はnilになるz
    init(movieDetail: MovieDetail? = nil) {
        self.movieDetail = movieDetail
    }
    
    ///IMDbIDに基づいて映画の詳細情報を取得するメソッド
    func getDetailsByImdbId(imdbId: String) {
        httpClient.getMovieDetailsBy(imdbId: imdbId) { result in
            switch result {
            case .success(let details):
                //成功時：メインスレッドで映画の詳細情報とロード状態を更新
                DispatchQueue.main.async {
                    self.movieDetail = details
                    self.loadingState = .success
                }
                
            case .failure(let error):
                //失敗時：エラーをログに出力し、ロード状態を更新
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
            }
        }
    }
    
    // 映画のタイトルを取得、データがない場合は空文字を返す
    var title: String {
        self.movieDetail?.title ?? ""
    }
    
    // 映画のポスターURLを取得、データがない場合は空文字を返す
    var poster: String {
        self.movieDetail?.poster ?? ""
    }
    
    // 映画のあらすじを取得、データがない場合は空文字を返す
    var plot: String {
        self.movieDetail?.plot ?? ""
    }
    
    // 映画の評価を取得、DoubleからIntへ変換して返す
    var rating: Int {
        get {
            let ratingAsDouble = Double(self.movieDetail?.imdbRating ?? "0.0")
            return Int(ceil(ratingAsDouble ?? 0.0))
        }
    }
    
    // 映画の監督名を取得、データがない場合は空文字を返す
    var director: String {
        self.movieDetail?.director ?? ""
    }
}
