//
//  AvatarAPI.swift
//  GitHubIssues
//
//  Created by Gustavo Amaral on 20/10/19.
//  Copyright © 2019 Gustavo Almeida Amaral. All rights reserved.
//

import Moya

enum AvatarAPI: TargetType {
    
    case avatar(id: Int)
    
    static func createBaseURL() -> URL {
        let urlString = "https://avatars1.githubusercontent.com"
        guard let url = URL(string: urlString) else { fatalError("The URL '\(urlString)' isn't valid") }
        return url
    }
    
    var baseURL: URL {
        return AvatarAPI.createBaseURL()
    }
    
    var path: String {
        switch self {
        case .avatar(let id):
            return "/u/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .avatar:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .avatar:
            return UIImage(named: "avatar")!.jpegData(compressionQuality: 0.95)!
        }
    }
    
    var task: Task {
        switch self {
        case .avatar:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .avatar:
            return nil
        }
    }
}
