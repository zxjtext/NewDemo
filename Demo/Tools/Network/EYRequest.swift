//
//  EYRequest.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit
import Moya
import RxSwift

let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<EYNetworkApi>.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //根据不同接口判断携带不同的请求头 //这个也可以根据接口判断，切换超时时长
        if(request.url?.absoluteString.contains(EYUrls.topGrossingApplications.lowercased()) ?? false){
            request.timeoutInterval = 60
            //request.addValue("zhangsan", forHTTPHeaderField: "user")
            //request.addValue("ahsfksjfhskdfhsjdkf", forHTTPHeaderField: "cookie")
        }else{
            //.....
            let url =  request.url?.absoluteString.replacingOccurrences(of: "?", with: "")
            request.url = URL(string: url!)
            request.timeoutInterval = 60
        }
        done(.success(request))
    } catch {
        return
    }
}

let networkPlugin = NetworkActivityPlugin {(state,target) in
    switch state {
    case .began:
        DispatchQueue.main.async {
            //SVProgressHUD.show()
        }
        
    case .ended:
        DispatchQueue.main.async {
            //SVProgressHUD.dismiss()
        }
    }
}
   

class EYRequest: NSObject {
    
    static let request = EYRequest()
    
    var provider = MoyaProvider<EYNetworkApi> (requestClosure: requestTimeoutClosure,plugins: [NetworkLoggerPlugin(),networkPlugin])
    
    public func getTopGrossingApplications() ->  Single<Result<topGrossingApplicationsModelArray>>{
        return provider.rx.request(.topGrossingApplications)
            .filterSuccessfulStatusCodes()
            .mapModel()
            .flatMap { (result:EYResponse<topGrossingApplicationsModelArray>) in
                if result.isSuccess{
                
                    return  Single.just(Result.regular(result.feed ?? topGrossingApplicationsModelArray()))
                }else{
                    
                    return Single.just(Result<topGrossingApplicationsModelArray>.failing(RxMoyaError.reason(result.message ?? "")))
                }
        }
        .catchError({ error in
            return Single.just(Result.failing(RxMoyaError.reason(ErrorTips.netWorkError.rawValue)))
        })
    }
    
    
    public func getTopfreeapplications(limit:String) ->  Single<Result<topGrossingApplicationsModelArray>>{
        return provider.rx.request(.topfreeapplications(limit: limit))
            .filterSuccessfulStatusCodes()
            .mapModel()
            .flatMap {(result:EYResponse<topGrossingApplicationsModelArray>) in
                if result.isSuccess{
                    
                    return  Single.just(Result.regular(result.feed ?? topGrossingApplicationsModelArray()))
                }else{
                    return Single.just(Result<topGrossingApplicationsModelArray>.failing(RxMoyaError.reason(result.message ?? "")))
                }
        }
        .catchError({ error in
            return Single.just(Result.failing(RxMoyaError.reason(ErrorTips.netWorkError.rawValue)))
        })
    }
    
}
