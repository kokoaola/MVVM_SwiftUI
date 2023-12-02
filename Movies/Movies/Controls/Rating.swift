//
//  Rating.swift
//  Movies
//
//  Created by koala panda on 2023/12/01.
//

import SwiftUI

///評価を星で表示するためのViewコンポーネント
struct Rating: View {
    
    //@Bindingプロパティラッパーを使用して外部から双方向にデータをバインド
    @Binding var rating: Int?
    
    //星の種類（塗りつぶしされた星か空の星か）を決定するメソッド
    private func starType(index: Int) -> String {
        //ratingが設定されている場合、現在のインデックスがrating以下なら塗りつぶされた星を、そうでなければ空の星を返す
        if let rating = self.rating {
            return index <= rating ? "star.fill" : "star"
        } else {
            //ratingが設定されていない場合は全て空の星を返す
            return "star"
        }
    }
    
    //Viewの本体
    var body: some View {
        //水平方向のスタックを生成し、1から10までの星を表示
        HStack {
            //1から10までループし、各星に対応するImageを生成
            ForEach(1...10, id: \.self) { index in
                //starTypeメソッドを使って星の種類を決定し、オレンジ色で表示
                Image(systemName: self.starType(index: index))
                    .foregroundColor(Color.orange)
                //星がタップされたら、そのインデックスをratingに設定
                    .onTapGesture {
                        self.rating = index
                    }
            }
        }
    }
}


struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: .constant(3))
    }
}
