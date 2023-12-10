//
//  CreateAccountRequest.swift
//  BankApp
//
//  Created by koala panda on 2023/12/10.
//

import Foundation

///サーバーにアカウントを作成するために必要な情報を格納したモデル
struct CreateAccountRequest: Codable {
    
    let name: String
    let accountType: String
    let balance: Double
    
}
