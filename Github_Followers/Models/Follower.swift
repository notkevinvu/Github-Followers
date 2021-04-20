//
//  Follower.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import Foundation

struct Follower: Codable {
    // both are non-optional as the github api will always return a non-nil/null
    // value for these properties in the response JSON
    var login: String
    var avatarUrl: String
}


// alternatively, we could forgo this implementation of coding keys
// and use the .convertFromSnakeCase keyDecodingStrategy when creating a
// JSONDecoder
extension Follower {
    enum CodingKeys: String, CodingKey {
        case login,
             avatarUrl = "avatar_url"
    }
}
