//
//  CreateAccountResponse.swift
//  BankApp
//
//  Created by koala panda on 2023/12/10.
//

import Foundation


//サーバーから取得する応答を格納する型
struct CreateAccountResponse: Decodable {
    let success: Bool
    let error: String?
}
