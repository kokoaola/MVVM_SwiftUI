//
//  ImageLoader.swift
//  Movies
//
//  Created by koala panda on 2023/12/01.
//

import Foundation


///URLの画像をロードする
//SwiftUIにはデフォルトでURLを取り込める画像コントロールがないため必要

class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?
    
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedData = data
            }
            
        }.resume()
        
    }
    
}
