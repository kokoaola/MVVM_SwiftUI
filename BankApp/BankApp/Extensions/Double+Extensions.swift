//
//  Double+Extensions.swift
//  BankApp
//
//  Created by koala panda on 2023/12/04.
//

import Foundation


/// 拡張機能: Double型の値を通貨形式の文字列にフォーマットする
extension Double {
    
    //Double型の値を通貨形式の文字列に変換
    func formatAsCurrency() -> String {
        //NumberFormatterインスタンスを作成
        let formatter = NumberFormatter()
        //フォーマットスタイルを通貨形式に設定
        formatter.numberStyle = .currency
        //Double型の値をNSNumberに変換し、通貨形式の文字列にフォーマット
        let formattedCurrency = formatter.string(from: self as NSNumber)
        //変換された文字列を返す、変換に失敗した場合は空文字列を返す
        return formattedCurrency ?? ""
    }
}
