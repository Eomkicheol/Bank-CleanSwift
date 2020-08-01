//
//  URLProtocolStub.swift
//  Bank-CleanSwiftTests
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

struct URLReponseStub {
    let data: Data?
    let error: Error?
    let response: URLResponse?
}

class URLProtocolStub: URLProtocol {
    
    static var responseStub: URLReponseStub?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let mockResponse = URLProtocolStub.responseStub else { return }

        if let data = mockResponse.data {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        if let reponse = mockResponse.response {
            self.client?.urlProtocol(self, didReceive: reponse, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = mockResponse.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }

}
