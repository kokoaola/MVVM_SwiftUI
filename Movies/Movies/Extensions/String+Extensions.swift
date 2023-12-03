//
//  String+Extensions.swift
//  Movies
//
//  Created by koala panda on 2023/12/02.
//

import Foundation



extension String {
    
    /// 文字列をトリム（前後の空白や改行を削除）し、URLエンコードする拡張メソッド
    func trimmedAndEscaped() -> String {
        // 文字列の前後の空白や改行を削除
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // URLエンコードを実行し、失敗した場合は元の文字列を返す
        return trimmedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}

