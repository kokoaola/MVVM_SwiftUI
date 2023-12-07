//
//  Account.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation


///モデルで使用するenum型
enum AccountType: String, Codable, CaseIterable {
    case checking
    case saving
}


//大文字で始まるキーなので、拡張機能内で切り替える
extension AccountType {

    var title: String {
        switch self {
        case .checking:
            return "Checking"
        case .saving:
            return "Saving"
        }
    }

}


///DTO(データ転送オブジェクト)のモデル
struct Account: Codable {
    
    var id: UUID
    var name: String
    let accountType: AccountType
    var balance: Double
}

