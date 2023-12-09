//
//  AccountSummaryViewModel.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation



/// アカウントの概要を管理するViewModel
class AccountSummaryViewModel: ObservableObject {
    
    /// アカウントモデルのプライベート配列
    private var _accountModels = [Account]()
    
    /// アカウントViewModelの配列を公開
    /// @Publishedをつけると値が変更された時に自動でビューが更新される
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    /// アカウントの合計残高を計算
    var total: Double {
        //0から各要素を合計して配列の全要素を一つの値にまとめる
        //ビューモデルは手が加えられる可能性があるため、ビューモデルを経由せずモデルオブジェクトからコピーした配列で計算する
        _accountModels.map { $0.balance }.reduce(0, +)
    }
    
    /// すべてのアカウントを取得するメソッド
    func getAllAccounts() {
        //アカウントサービスを開始
        AccountService.shared.getAllAccounts { result in
            //結果のresult型を判定
            switch result {
                //成功：ビューに表示するために、ビューモデルのインスタンスを生成
            case .success(let accounts):
                //アンラップに成功したら
                if let accounts = accounts {
                    //total計算用のrowData
                    self._accountModels = accounts
                    //accounts配列の全ての要素をAccountViewModel型のインスタンスに初期化
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
                
                //失敗：エラーをprint
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


/// アカウントに関連するデータのViewModel
/// 必要なデータのみを抽出して、必要な形式でビューに送信するため
class AccountViewModel {
    
    var account: Account
    
    /// アカウントモデルを初期化
    init(account: Account) {
        self.account = account
    }
    
    /// アカウント名を取得
    var name: String {
        account.name
    }
    
    /// アカウントIDを取得
    var accountId: String {
        account.id.uuidString
    }
    
    /// アカウントタイプを取得
    var accountType: String {
        account.accountType.title
    }
    
    /// アカウント残高を取得
    var balance: Double {
        account.balance
    }
}
