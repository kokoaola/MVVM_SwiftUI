//
//  AccountService.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation



/// ネットワークエラーを定義する列挙型
enum NetworkError: Error {
    // URLが無効
    case badUrl
    // デコードエラー
    case decodingError
    // データが存在しない
    case noData
}



/// アカウント関連のサービスを提供するクラス
class AccountService {
    
    // シングルトンインスタンス
    //ユーザーがアカウント サービスの複数のインスタンスを作成できないようにする
    static let shared = AccountService()
    
    // 初期化をプライベートに設定し、シングルトンとして利用
    //これにより、呼び出し元がアカウントサービスの複数のインスタンスを作成できなくなる
    private init() { }
    
    //シングルトンは、プログラミングにおいて、あるクラスのインスタンスが一つだけ作られることを保証するデザインパターンです。このパターンを使うと、そのクラスのインスタンスにアプリケーション全体からアクセスできるようになります。これは、特定のデータや機能がアプリ全体で共有されるべき場合に便利です。ただし、使いすぎるとコードが複雑になる可能性があるので注意が必要です。
    
    /// すべてのアカウントを取得するメソッド
    /// 成功したらアカウント配列を返し、失敗した場合は、ネットワークエラーを実行
    func getAllAccounts(completion: @escaping (Result<[Account]?,NetworkError>) -> Void) {
        
        // アカウントのURLを生成し、無効な場合はエラーを返す
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        // URLSessionを使ってデータタスクを作成し実行
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // アンラップ
            //データが存在しない、またはエラーがある場合はコンプリーションハンドラを実行しエラーを返す
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // JSONDecoderを使用してデータからアカウントの配列をデコード
            let accounts = try? JSONDecoder().decode([Account].self, from: data)
            
            // アカウントがnilの場合はデコードエラーを返す
            if accounts == nil {
                completion(.failure(.decodingError))
            } else {
                // 成功した場合はアカウントの配列を返す
                completion(.success(accounts))
            }
            
        }.resume() // データタスクを開始
    }
}

