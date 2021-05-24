//
//  testViewModel.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit
import RxSwift

class ViewModel: NSObject {
    static var shared: ViewModel = ViewModel()
    var dispose = DisposeBag()
    public typealias NetworkResultClosure = ((Any?)) -> Void
    let tipsStrOB = BehaviorSubject(value: "")
    func fetchGrossingApplicationsData(networkResultClosure: @escaping NetworkResultClosure){
        _ =  EYRequest.request.getTopGrossingApplications().subscribe(onSuccess: { (result) in
            switch result{
            case.regular(let data):
                networkResultClosure(data)
            case .failing( _):
                break
            }
        }) { (error) in
            
        }.disposed(by: dispose)
    }
    
    func fetchTopfreeapplicationsData(limit:String,networkResultClosure: @escaping NetworkResultClosure){
        _ =  EYRequest.request.getTopfreeapplications(limit:limit).subscribe(onSuccess: { (result) in
            switch result{
            case.regular(let data):
                networkResultClosure(data)
            case .failing( _):
                break
            }
        }) { (error) in
            
        }.disposed(by: dispose)
    }
}




