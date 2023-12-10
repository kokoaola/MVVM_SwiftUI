//
//  AddAccountViewModel.swift
//  BankApp
//
//  Created by koala panda on 2023/12/10.
//

import Foundation



/// AddAccountViewModelはアカウント追加に必要な全てのことを担当するビューモデル
/// ObservableObjectプロトコルを実装しているので、ビューの状態を監視できる
class AddAccountViewModel: ObservableObject {
    
    // アカウントの名前
    var name: String = ""
    // アカウントの種類、デフォルトでは当座預金に設定
    var accountType: AccountType = .checking
    // アカウントの初期残高
    var balance: String = ""
    // エラーメッセージを表示するためのPublishedプロパティ
    @Published var errorMessage: String = ""
    
}

/// 入力内容を検証するための拡張機能
extension AddAccountViewModel {
    
    // 名前が有効かどうかをチェックするプロパティ
    private var isNameValid: Bool {
        !name.isEmpty
    }
    
    // 残高が有効かどうかをチェックするプロパティ
    private var isBalanceValid: Bool {
        // 残高が数値に変換できるか、かつ0より大きいかをチェック
        guard let userBalance = Double(balance) else {
            return false
        }
        
        return userBalance > 0
    }
    
    // 入力されたデータが全て有効かどうかをチェックするメソッド
    private func isValid() -> Bool {
        
        var errors = [String]()
        
        // 名前が無効ならエラー配列に追加
        if !isNameValid {
            errors.append("Name is not valid")
        }
        
        // 残高が無効ならエラー配列に追加
        if !isBalanceValid {
            errors.append("Balance is not valid")
        }
        
        // エラーがあればerrorMessageにセットし、falseを返す
        if !errors.isEmpty {
            DispatchQueue.main.async {
                self.errorMessage = errors.joined(separator: "\n")
            }
            return false
        }
        
        return true
    }
    
}

// AddAccountViewModelの拡張
extension AddAccountViewModel {
    
    /// アカウントを作成するメソッド
    //Bool型のパラメータを取り、何も返さない（Void）クロージャ
    //ネットワークリクエストが完了した時点で、このクロージャが実行される
    //関数が非同期処理を行い、その結果（成功か失敗かを表す真偽値）をあとで通知するためのクロージャを受け取る
    func createAccount(completion: @escaping (Bool) -> Void) {
        
        // 入力値が有効でなければfalseを返して終了
        if !isValid() { return completion(false) }
        
        // CreateAccountRequestを作成
        let createAccountReq = CreateAccountRequest(name: name, accountType: accountType.rawValue, balance: Double(balance)!)
        
        // AccountServiceを通じてアカウント作成リクエストを送信
        AccountService.shared.createAccount(createAccountRequest: createAccountReq) { result in
            switch result {
                // リクエスト成功
            case .success(let response):
                if response.success {
                    completion(true)
                } else {
                    // サーバーエラーがあればエラーメッセージをセットし、falseを返す
                    if let error = response.error {
                        DispatchQueue.main.async {
                            self.errorMessage = error
                        }
                        completion(false)
                    }
                }
                // リクエスト失敗
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}

