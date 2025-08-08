//
//  RepositoryModel.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import ObjectMapper

class RepositoryModel: Mappable, Identifiable {
    let id = UUID()
    var fullName: String?
    var description: String?

    var topics: [String]?
    var avatarUrl: String?
    var owner: [String: Any]?
    required init?(map: Map) {}
    func mapping(map: Map) {
        if let name = map.JSON["full_name"] as? String {
            fullName = name
        } else if let name = map.JSON["name"] as? String {
            fullName = name
        }
        description <- map["description"]
        owner <- map["owner"]
        avatarUrl = owner?["avatar_url"] as? String
        topics <- map["topics"]
    }
}
