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
    let login: String
    let avatarUrl: String
    // below optional values are not guaranteed - still not sure how to
    // determine whether a JSON key is nullable or not from API (or even docs)
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
