//
//  EYNetworkApi.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import Moya

enum EYNetworkApi {
    case topGrossingApplications
    case topfreeapplications(limit:String)
    case lookup(id:String)
}

extension EYNetworkApi:TargetType{

    var baseURL: URL {
        return URL(string: EYUrls.domain)!
    }
    
    var path: String {
        switch self {
        case .topGrossingApplications:
            return EYUrls.topGrossingApplications
        case .topfreeapplications(_):
            return EYUrls.topfreeapplications
        case .lookup(_):
            return EYUrls.lookup
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topGrossingApplications:
            return .get
        case .topfreeapplications(_):
            return .get
        case .lookup(_):
            return .get
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .topGrossingApplications:
            let params = EYParams.init()
            return .requestParameters(parameters: params.allParams, encoding: URLEncoding.default)
        case .topfreeapplications(let limit):
            let params = EYParams.init(params: ["limit" : limit])
            return .requestParameters(parameters: params.allParams, encoding: URLEncoding.default)
        case .lookup(let id):
            let params = EYParams.init(params: ["id" : id])
            return .requestParameters(parameters: params.allParams, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}

