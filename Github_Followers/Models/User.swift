//
//  User.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import Foundation

// see example response from API docs to determine what properties we might
// want and which ones are possibly nullable (also can ping server manually
// with curl in terminal
struct User: Codable {
    var login: String
    var avatarUrl: String
    // below optional values are not guaranteed - still not sure how to
    // determine whether a JSON key is nullable or not from API (or even docs)
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var following: Int
    var followers: Int
    var createdAt: String
}
