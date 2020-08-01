//
//  ApiProvider.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit


protocol ApiProvider {
    
    typealias Result = Swift.Result<Data, Error>
    
    func login(userName: String, password: String, callbackHandler: @escaping (Result) -> Void)

}
