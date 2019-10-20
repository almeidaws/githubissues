//
//  LoginTests.swift
//  GitHubIssuesTests
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
@testable import GitHub_Issues

class LoginTests: XCTestCase {

    private var successfullLoginExpectation: XCTestExpectation!
    private var successfullLoginUser: User!
    
    private var loginFailureError: LoginError!
    private var loginFailureExpectation: XCTestExpectation!
    
    private var successfullLogoutExpectation: XCTestExpectation!
    
    private var logoutFailureError: LoginError!
    private var logoutFailureExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        self.successfullLoginExpectation = nil
        self.successfullLoginUser = nil
        
        self.loginFailureError = nil
        self.loginFailureExpectation = nil
        
        self.successfullLogoutExpectation = nil
        
        self.logoutFailureError = nil
        self.logoutFailureExpectation = nil
    }
    
    func testSuccessfullLogin() {
        let login = LoginProviderMock()
        let user = User(id: "1", name: "John", email: "john@apple.com")
        login.user = user
        login.delegate = self
        
        let expectation = XCTestExpectation(description: "Wait successfull login")
        self.successfullLoginExpectation = expectation
        
        login.login()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(user, self.successfullLoginUser)
    }
    
    func testLoginFailure() {
        let login = LoginProviderMock()
        let error = LoginError.userCancelledLogin
        login.error = error
        login.delegate = self
        
        let expectation = XCTestExpectation(description: "Wait login failure")
        self.loginFailureExpectation = expectation
        
        login.login()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(error, self.loginFailureError)
    }
    
    func testLogoutSuccess() {
        let login = LoginProviderMock()
        login.delegate = self
        
        let expectation = XCTestExpectation(description: "Wait successfull logout")
        self.successfullLogoutExpectation = expectation
        
        login.logout()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLogoutFailure() {
        let login = LoginProviderMock()
        let error = LoginError.withoutAuthDataResult
        self.loginFailureError = error
        login.error = error
        login.delegate = self
        
        let expectation = XCTestExpectation(description: "Wait logout failure")
        self.logoutFailureExpectation = expectation
        
        login.logout()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(error, self.loginFailureError)
    }
}

extension LoginTests: LoginDelegate {
    
    func login(_ login: Login, didLogout result: Result<Void, LoginError>) {
        if case .success = result {
            self.successfullLogoutExpectation.fulfill()
        } else if case let .failure(error) = result {
            self.logoutFailureError = error
            self.logoutFailureExpectation.fulfill()
        }
    }
    
    func login(_ login: Login, didLogin result: Result<User, LoginError>) {
        if case let .success(user) = result {
            self.successfullLoginUser = user
            self.successfullLoginExpectation.fulfill()
        } else if case let .failure(error) = result {
            self.loginFailureError = error
            self.loginFailureExpectation.fulfill()
        }
    }
}
