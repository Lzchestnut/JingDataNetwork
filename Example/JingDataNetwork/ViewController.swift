//
//  ViewController.swift
//  JingDataNetwork
//
//  Created by tianziyao on 08/22/2018.
//  Copyright (c) 2018 tianziyao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import JingDataNetwork
import Moya
import SwiftyJSON

class ViewController: UIViewController {
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        sequencerDifferentZipResponse()
        base()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func base() {
        
        // 获取 response
        JingDataNetworkManager.base(api: ApiService.user(userId: ""))
            .bind(BaseResponseHandler.self)
            .single()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (data) in
                print(data + "11111111")
            }, onFailure: { (error) in
                print(error.localizedDescription + "error")
            })
            .disposed(by: bag)
        
        // 获取 response.data
        JingDataNetworkManager.base(api: ApiService.userQuery(keyword: ""))
            .bind(BaseDataResponseHandler<BaseDataResponse>.self)
            .single()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (data) in
                print(data.count)
            })
            .disposed(by: bag)
        
        // 获取 response.listData
        JingDataNetworkManager.base(api: ApiService.login(username: "", password: ""))
            .bind(BaseListDataResponseHandler<BaseListDataResponse>.self)
            .single()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (listData) in
                print(listData.count)
            })
            .disposed(by: bag)
    }
    
    func sequencerSameModel() {
        let sequencer = JingDataNetworkSequencer.sameHandler(BaseListDataResponseHandler<BaseListDataResponse>.self)
        sequencer.zip(apis: [ApiService.userQuery(keyword: ""), ApiService.user(userId: "")])
            .subscribe(onSuccess: { (responseList) in
                print(responseList.map({$0.listData}))
            })
        .disposed(by: bag)
        
        sequencer.map(apis: [ApiService.userQuery(keyword: ""), ApiService.user(userId: "")])
            .subscribe(onNext: { (response) in
                print(response.listData)
            })
        .disposed(by: bag)
    }
    
    func sequencerDifferentMapResponse() {
        let sequencer = JingDataNetworkSequencer.differentHandlerMap
        sequencer.next(bind: BaseResponseHandler.self, api: {ApiService.userQuery(keyword: "")}, success: { (response) in
            print(response)
        })
        sequencer.next(bind: BaseListDataResponseHandler<BaseListDataResponse>.self, with: { (data: String) -> ApiService? in
            print(data)
            return .userQuery(keyword: "")
        }, success: { (response) in
            print(response)
        })
        sequencer.next(bind: BaseListDataResponseHandler<BaseListDataResponse>.self, with: { (data: BaseListDataResponse) -> ApiService? in
            print(data)
            return .userQuery(keyword: "")
        }, success: { (response) in
            print(response)
        })
        sequencer.run().asObservable()
            .subscribe(onNext: { (results) in
                print(results)
            })
        .disposed(by: bag)
    }

    
    func sequencerDifferentZipResponse() {
        let task1 = JingDataNetworkTask(api: ApiService.userQuery(keyword: ""), handler: BaseResponseHandler.self)
        let task2 = JingDataNetworkTask(api: ApiService.login(username: "", password: ""), handler: BaseListDataResponseHandler<BaseListDataResponse>.self)
        let sequencer = JingDataNetworkSequencer.differentHandlerZip
        sequencer.zip(task1, task2).subscribe(onSuccess: { (data1, data2) in
            print(data1, data2)
        }).disposed(by: bag)
        
    }
}

