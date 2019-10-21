//
//  IssuesTests.swift
//  GitHubIssuesTests
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Moya
@testable import GitHub_Issues

class IssuesTests: XCTestCase {
    
    func testIssuesRequestDecoding() {
        let endpointClosure = { (target: GitHubAPI) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: { .networkResponse(200, target.sampleData ) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<GitHubAPI>(endpointClosure: endpointClosure)
        
        let expectation = XCTestExpectation(description: "Wait network call")
        provider.request(.allIssues(owner: "apple", repo: "swift")) { (result) in
            if case .success(let response) = result {
                XCTAssertEqual(response.statusCode, 200)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                XCTAssertNoThrow(try! decoder.decode([Issue].self, from: response.data))
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
