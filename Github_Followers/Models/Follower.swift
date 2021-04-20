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
    public var login: String
    // avatarUrl is actually avatar_url in JSON response. We can use the
    // .convertFromSnakeCase keyDecodingStrategy when creating a Decoder object
    // to handle these cases
    public var avatarUrl: String
}



//extension Follower {
//    enum CodingKeys: String, CodingKey {
//        case login,
//             avatarUrl = "avatar_url"
//    }
//}
