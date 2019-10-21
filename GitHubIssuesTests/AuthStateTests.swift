//
//  AuthStateTests.swift
//  GitHubIssuesTests
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
@testable import GitHub_Issues

class AuthStateTests: XCTestCase {
    
    private var userAuthenticatedExpectation: XCTestExpectation!
    private var authenticatedUser: User?
    private var userUnauthenticatedExpectation: XCTestExpectation!
    private var authStateErrorExpectation: XCTestExpectation!
    private var authStateError: AuthStateError?

    override func setUp() {
        self.userAuthenticatedExpectation = nil
        self.authenticatedUser = nil
        self.userUnauthenticatedExpectation = nil
        self.authStateErrorExpectation = nil
        self.authStateError = nil
    }
    
    func testUserAuthenticated() {
        let authState = AuthStateMock()
        let user = User(id: "1", name: "John", email: "john@apple.com")
        authState.user = user
        authState.delegate = self
        
        self.userAuthenticatedExpectation = XCTestExpectation(description: "Check user authentication")
        authState.startObserving()
        wait(for: [self.userAuthenticatedExpectation], timeout: 1)
        
        XCTAssertEqual(user, self.authenticatedUser)
    }
    
    func testUserUnauthenticated() {
        let authState = AuthStateMock()
        authState.delegate = self
        
        self.userUnauthenticatedExpectation = XCTestExpectation(description: "Check user not authenticated")
        authState.startObserving()
        wait(for: [self.userUnauthenticatedExpectation], timeout: 1)
        
        XCTAssertNil(self.authenticatedUser)
    }
    
    func testAuthStateError() {
        let authState = AuthStateMock()
        let error = AuthStateError.login(.userCancelledLogin)
        authState.error = error
        authState.delegate = self
        
        self.authStateErrorExpectation = XCTestExpectation(description: "Check if there's an error")
        authState.startObserving()
        wait(for: [self.authStateErrorExpectation], timeout: 1)
        
        XCTAssertEqual(error, self.authStateError)
    }

}

extension AuthStateTests: AuthStateDelegate {
    func authState(_ authState: AuthState, didChange result: Result<User?, AuthStateError>) {
        switch result {
        case .success(let user?):
            self.authenticatedUser = user
            self.userAuthenticatedExpectation.fulfill()
        case .success:
            self.authenticatedUser = nil
            self.userUnauthenticatedExpectation.fulfill()
        case .failure(let error):
            self.authStateError = error
            self.authStateErrorExpectation.fulfill()
        }
    }
}
