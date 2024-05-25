//
//  MockURLSession.swift
//  WaveCastTests
//
//  Created by Gonzalo Trujillo Vallejo on 26/5/24.
//

import Foundation

class MockURLSession: URLSession {
    private let mockData: Data?
    private let mockResponse: URLResponse?
    private let mockError: Error?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.mockData = data
        self.mockResponse = urlResponse
        self.mockError = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = mockData
        let response = mockResponse
        let error = mockError
        
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
