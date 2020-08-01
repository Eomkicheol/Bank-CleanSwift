//
//  BankHttpProvider.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import Foundation

private struct Api {
    static let https = "https"
    static let baseURL = "bank-app-test.herokuapp.com"
    static let postMethod = "POST"
    
    static let loginPath = "/api/login"
    static let contentTypeHeaderKey = "Content-Type"
    static let contentTypeHeaderLoginValue = "application/x-www-form-urlencoded"
    static let userNameKey = "user"
    static let passwordKey = "password"
    
    static let kApiKey = "api_key"
    static let kPage = "page"
    static let kLanguage = "language"
    static let kQuery = "query"
}

class BankHttpProvider: ApiProvider {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func login(userName: String, password: String, callbackHandler: @escaping (ApiProvider.Result) -> Void) {
        let urlRequest = self.buildURLLogin(userName: userName, password: password)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                callbackHandler(.failure(error))
            } else if let data = data {
                callbackHandler(.success(data))
            }
        }
        task.resume()
    }
    
    private func buildURLLogin(userName: String, password: String) -> URLRequest {
        var urlComponent = self.buidBaseURLPageComponents()
        urlComponent.path = Api.loginPath
        
        guard let url = urlComponent.url else { fatalError("should have genrerate login url") }
        var request = URLRequest(url: url)
        request.httpMethod = Api.postMethod
        request.addValue(Api.contentTypeHeaderLoginValue, forHTTPHeaderField: Api.contentTypeHeaderKey)
        self.appendUserAndPassword(request: &request, userName: userName, password: password)
        return request
    }
    
    private func appendUserAndPassword(request: inout URLRequest, userName: String, password: String) {
        var parameters = URLComponents()
        parameters.queryItems = [
            URLQueryItem(name: Api.userNameKey, value: userName),
            URLQueryItem(name: Api.passwordKey, value: password)
        ]
        request.httpBody = parameters.percentEncodedQuery?.data(using: .utf8)
    }
    
    private func buidBaseURLPageComponents() -> URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = Api.https
        urlComponent.host = Api.baseURL
        return urlComponent
    }
    

}
