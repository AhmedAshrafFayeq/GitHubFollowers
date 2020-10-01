//
//  User.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/10/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
