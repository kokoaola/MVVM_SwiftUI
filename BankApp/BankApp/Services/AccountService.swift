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
    
    
    
    /// createAccountは新しいアカウントを作成するためのメソッド
    /// createAccountRequestを受け取り、非同期でサーバーにアカウント作成リクエストを送る
    /// 結果はResult型でcompletionハンドラを通じて返される
    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {
        
        // URL.urlForCreateAccountsを使用してアカウント作成用のURLを取得
        // URLが取得できない場合はエラーを返す
        guard let url = URL.urlForCreateAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        // URLRequestを作成し、HTTPメソッド、ヘッダ、ボディを設定
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //送信する実際のコンテンツ
        request.httpBody = try? JSONEncoder().encode(createAccountRequest)
        
        // URLSessionを使用して非同期でデータタスクを作成し、実行
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // レスポンスデータが存在し、エラーがないことを確認
            // そうでない場合はエラーを返す
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // 受け取ったデータをJSONデコードしてCreateAccountResponse型に変換
            let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data)
            
            // デコードが成功した場合は成功結果を返し、失敗した場合はエラーを返す
            if let createAccountResponse = createAccountResponse {
                completion(.success(createAccountResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume() // データタスクを開始
    }
    
    
    
    
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

