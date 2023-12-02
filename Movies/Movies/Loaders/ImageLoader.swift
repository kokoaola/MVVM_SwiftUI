//
//  ImageLoader.swift
//  Movies
//
//  Created by koala panda on 2023/12/01.
//

import Foundation


///URLから画像をダウンロードしてロードするためのクラス
///SwiftUIにはデフォルトでURLから画像をロードする機能がないため、このクラスで処理を実装
class ImageLoader: ObservableObject {
    
    //@Publishedプロパティラッパーを使用してダウンロードされたデータを監視
    @Published var downloadedData: Data?
    
    //指定されたURLから画像をダウンロードするメソッド
    func downloadImage(url: String) {
        //URL文字列からURLインスタンスを生成、無効な場合は処理を中止
        guard let imageURL = URL(string: url) else {
            return
        }
        
        //URLSessionを使用して非同期でデータタスクを実行
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            //データが存在し、エラーがない場合のみ処理を続行
            guard let data = data, error == nil else {
                return
            }
            
            //メインスレッドでダウンロードされたデータをpublishedプロパティにセット
            //UIの更新が必要なためメインスレッドで実行
            DispatchQueue.main.async {
                self.downloadedData = data
            }
            
        //DataTaskを開始
        }.resume()
    }
}
