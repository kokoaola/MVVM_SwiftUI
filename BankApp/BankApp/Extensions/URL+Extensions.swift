//
//  URL+Extensions.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation



/// 拡張機能: URLの生成に関するメソッドを提供
extension URL {
    
    //アカウント関連のAPIエンドポイントのURLを生成
    static func urlForAccounts() -> URL? {
        //指定された文字列からURLを生成
        return URL(string: "https://bank-api.glitch.me/api/accounts")
    }
    
    //アカウント作成に関するAPIエンドポイントのURLを生成
    static func urlForCreateAccounts() -> URL? {
        //指定された文字列からURLを生成
        return URL(string: "https://bank-api.glitch.me/api/accounts")
    }
    
    
    //送金時に称するURLを生成
    static func urlForTransferFunds() -> URL? {
        return URL(string: "https://bank-api.glitch.me/api/transfer")
    }
}
