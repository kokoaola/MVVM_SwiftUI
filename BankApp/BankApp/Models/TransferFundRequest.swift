//
//  TransferFundRequest..swift
//  BankApp
//
//  Created by koala panda on 2023/12/11.
//

import Foundation


//送金のリクエストをサーバーに送るための型
struct TransferFundRequest: Codable {
    
    let accountFromId: String
    let accountToId: String
    let amount: Double
    
}


