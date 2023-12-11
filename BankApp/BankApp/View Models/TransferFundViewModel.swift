//
//  TransferFundViewModel.swift
//  BankApp
//
//  Created by koala panda on 2023/12/11.
//

import Foundation



/// TransferFundsViewModelは資金の移動（送金）関連のビューモデル
/// ObservableObjectプロトコルを実装しているので、ビューの状態が変更されるとUIが更新される
class TransferFundsViewModel: ObservableObject {
    
    // 送金元のアカウントViewModel
    var fromAccount: AccountViewModel?
    // 送金先のアカウントViewModel
    var toAccount: AccountViewModel?
    
    // ユーザーに表示されるメッセージ
    @Published var message: String?
    // 利用可能な全アカウントのリスト
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    // 送金額
    var amount: String = ""
    
    // 送金額が有効かどうかをチェックするプロパティ
    var isAmountValid: Bool {
        // 送金額が数値に変換できるか、かつ0より大きいかをチェック
        guard let userAmount = Double(amount) else {
            return false
        }
        
        return userAmount > 0
    }
    
    // fromAccountが設定されている場合にそれ以外のアカウントをフィルタリングするプロパティ
    var filteredAccounts: [AccountViewModel] {
        // fromAccountがnilの場合は全アカウントを返す
        if self.fromAccount == nil {
            return accounts
        } else {
            // それ以外の場合はfromAccount以外のアカウントをフィルタリングして返す
            return accounts.filter {
                guard let fromAccount = self.fromAccount else {
                    return false
                }
                return $0.accountId != fromAccount.accountId
            }
        }
    }
    
    // 送金元のアカウントタイプを返すプロパティ
    var fromAccountType: String {
        // fromAccountがnilでない場合はそのアカウントタイプを返す
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    // 送金先のアカウントタイプを返すプロパティ
    var toAccountType: String {
        // toAccountがnilでない場合はそのアカウントタイプを返す
        toAccount != nil ? toAccount!.accountType : ""
    }
    
    // 入力されたデータが全て有効かどうかをチェックするメソッド
    private func isValid() -> Bool {
        // isAmountValidプロパティを使用して送金額の有効性をチェック
        return isAmountValid
    }
    
    
    
    
    /// populateAccountsは利用可能な全アカウントを取得し、accounts配列にセットするメソッド
    /// AccountServiceを通じて非同期でアカウントデータを取得し、結果をaccountsプロパティにセットする
    func populateAccounts() {
        // AccountServiceを使用して全アカウントデータを非同期で取得
        AccountService.shared.getAllAccounts { result in
            // リクエストの結果に基づいて処理
            switch result {
            case .success(let accounts):
                // リクエスト成功の場合
                if let accounts = accounts {
                    // メインスレッドでaccountsプロパティを更新
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                // リクエスト失敗の場合
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    /// submitTransferは送金リクエストをサーバーに送るメソッド
    /// すべての入力が有効な場合にのみ送金リクエストを行い、結果をcompletionハンドラで返す
    func submitTransfer(completion: @escaping () -> Void) {
        // 入力データが有効でない場合は処理を中断
        if !isValid() {
            return
        }
        
        // 送金元、送金先、送金額が有効な場合にのみ処理を続行
        guard let fromAccount = fromAccount,
              let toAccount = toAccount,
              let amount = Double(amount)
        else {
            return
        }
        
        // 送金リクエストデータを作成
        let transferFundRequest = TransferFundRequest(accountFromId: fromAccount.accountId.lowercased(), accountToId: toAccount.accountId.lowercased(), amount: amount)
        
        // AccountServiceを通じて送金リクエストを送信
        AccountService.shared.transferFunds(transferFundRequest: transferFundRequest) { result in
            // リクエストの結果に基づいて処理
            switch result {
            case .success(let response):
                // リクエスト成功かつサーバー側で処理成功の場合
                if response.success {
                    completion()
                } else {
                    // サーバー側でエラーが発生した場合
                    self.message = response.error
                }
            case .failure(let error):
                // リクエスト自体が失敗した場合
                self.message = error.localizedDescription
            }
        }
    }
}

