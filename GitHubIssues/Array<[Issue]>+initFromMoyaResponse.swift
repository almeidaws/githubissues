//
//  Array<[Issue]>+initFromMoyaResponse.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 19/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Moya

extension Array where Element == Issue {
    init(_ moyaResponse: Response) throws {
        guard moyaResponse.statusCode == 200 else {
            throw GitHubAPIError.unexpectedStatusCode(moyaResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        self = try decoder.decode([Issue].self, from: moyaResponse.data)
    }
}
