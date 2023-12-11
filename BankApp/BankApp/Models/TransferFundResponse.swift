//
//  TransferFundResponse.swift
//  BankApp
//
//  Created by koala panda on 2023/12/11.
//

import Foundation


struct TransferFundResponse: Decodable {
    let success: Bool
    let error: String?
}
