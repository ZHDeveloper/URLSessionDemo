//
//  ViewController.swift
//  DemoSwift
//
//  Created by ZhiHua Shen on 2018/1/2.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit

struct UpdateRequest: Requestable {
    
    var path: String {
        return "public/checkupdate"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    typealias Response = BaseModel
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = UpdateRequest()
        
        ApiSession.shared.send(request) { (result) in
            
            print(Thread.current)
            
            switch result {
            case .success(let resp):
                print(resp)
                break
            case .failed(let error):
                print(error.localizedDescription)
                break
            }
            
        }
        
    }


}

