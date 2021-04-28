//
//  Follower.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import Foundation

struct Follower: Codable, Hashable {
    // both are non-optional as the github api will always return a non-nil/null
    // value for these properties in the response JSON
    let login: String
    // avatarUrl is actually avatar_url in JSON response. We can use the
    // .convertFromSnakeCase keyDecodingStrategy when creating a Decoder object
    // to handle these cases
    let avatarUrl: String
}

