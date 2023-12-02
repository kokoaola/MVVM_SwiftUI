//
//  URLImage.swift
//  Movies
//
//  Created by koala panda on 2023/12/01.
//


import SwiftUI


///指定されたURLから画像をダウンロードして表示するためのView
struct URLImage: View {
    
    //画像のURL
    let url: String
    //プレースホルダー画像名
    let placeholder: String
    
    //@ObservedObjectを使用してImageLoaderクラスのインスタンスを監視
    @ObservedObject var imageLoader = ImageLoader()
    
    //初期化時にURLとプレースホルダー画像を設定し、画像のダウンロードを開始
    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }
    
    //Viewの本体
    var body: some View {
        //ImageLoaderからダウンロードされたデータがある場合はそれを表示
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!).resizable()
        } else {
            //データがない場合はプレースホルダー画像を表示
            return Image("placeholder").resizable()
        }
    }
}


struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
    }
}
