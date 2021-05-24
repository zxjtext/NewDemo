//
//  EYUrls.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit

class EYUrls{
    static let service: String = "https://itunes.apple.com/hk/rss"
    static var domain: String {
        return EYUrls.service
    }
    //topgrossingapplications
    static var topGrossingApplications: String {
        return "/topgrossingapplications/limit=10/json"
    }
    //topfreeapplications
    static var topfreeapplications: String {
        return "/topfreeapplications/"
    }
}
