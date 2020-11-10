//
//  RepositoryModel.swift
//  GitHubSearch
//
//  Created by Philip on 10.11.2020.
//

import Foundation

// MARK: - Repositories
struct Repositories: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Repository
struct Repository: Codable {
    let id: Int?
    let fullName: String?
    let stargazersCount: Int?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case description
    }
}
