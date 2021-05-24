//
//  EYParams.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit

class EYBaseParams: NSObject {
    var baseParams:[String:Any]?{
        let tempParams:[String:Any] = [String:Any]()
        //tempParams["channel"] = channel
        //tempParams["vno"] = vno
        return tempParams
    }
    var allParams:[String:Any]!
}


class EYParams: EYBaseParams {
    
    init(params:[String:Any]? = [String:Any]()) {
        super.init()
        var tempParams = [String:Any]()
        for param in baseParams ?? [String:Any](){
            tempParams[param.key] = param.value
        }
        for param in params ?? [String:Any](){
            tempParams[param.key] = param.value
        }
        allParams = tempParams
    }

}
