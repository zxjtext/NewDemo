//
//  EYResponse.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import HandyJSON




extension Array: HandyJSON {}
extension String: HandyJSON {}

struct EYResponse<T:HandyJSON>:HandyJSON{
    
    var code:Int = 0
    var message:String?
    var feed: T?
    var results: T?
    var isSuccess: Bool {
         return code == 0
     }
}

extension Response {

    func mapModel<T>() throws -> EYResponse<T> {
        do {
            
            if var jsonString = String(data: data, encoding: String.Encoding.utf8){
                jsonString = jsonString.replacingOccurrences(of: "im:", with: "")
                jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
                if let obj = JSONDeserializer<EYResponse<T>>.deserializeFrom(json: jsonString) {
                    
                    return obj
                }
                
                throw RxMoyaError.modelMapping(self)
                
            } else {
                
                throw RxMoyaError.modelMapping(self)
            }

        } catch {
            
            throw RxMoyaError.modelMapping(self)
        }
    }
    
    // MARK: 字符串转字典
    func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!,
                        options: .mutableContainers) as? [String : Any] {
            return dict
        }

        return nil
    }

}


extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapModel<T: HandyJSON>() -> Single<EYResponse<T>> {
        return flatMap { (response) -> Single<EYResponse<T>> in
            return Single.just(try response.mapModel())
        }
    }
}
