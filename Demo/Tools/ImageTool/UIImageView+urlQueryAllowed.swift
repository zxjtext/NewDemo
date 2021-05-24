//
//  UIImage+urlQueryAllowed.swift
//  POYA
//
//  Created by zxj on 2020/7/31.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(image:String) {
        let imageUrl = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let imageSource = imageUrl else {
            return
        }
		ImageDownloader.default.downloadTimeout = 120.0 //修改圖片下載請求超時時間
        self.kf.setImage(with: URL(string:imageSource))
    }
    
    func setImage(image:String,placeholder:String) {
        let imageUrl = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let imageSource = imageUrl else {
            return
        }
		ImageDownloader.default.downloadTimeout = 120.0 //修改圖片下載請求超時時間
        self.kf.setImage(with: URL(string:imageSource),placeholder:UIImage(named: placeholder))
    }
}
