//
//  UserModel.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.

import Foundation

class UserModel: Codable {
    var token: String = ""
    var name: String = ""
    var avatarUrl: String = ""
    var createdAt: String = ""
    var updatedAt: String = ""

    var followers: String = ""
    var publicGists: String = ""
    var following: String = ""
    var publicRepos: String = ""

    private static var currentUser = UserModel()

    static func getCurrentUser() -> UserModel {
        return currentUser
    }

    static func updateCurrentUser(user: UserModel) {
        currentUser = user
        saveNonSensitiveDataToCache()
    }

    static func createUser(json: [String: Any], token: String) -> UserModel {
        let user = UserModel()
        user.token = token
        user.name = (json["login"] as? String) ?? ""
        user.createdAt = (json["created_at"] as? String) ?? ""
        user.updatedAt = (json["updated_at"] as? String) ?? ""
        user.avatarUrl = (json["avatar_url"] as? String) ?? ""

        // 处理数字类型转换
        user.followers = "\(json["followers"] as? Int ?? 0)"
        user.publicGists = "\(json["public_gists"] as? Int ?? 0)"
        user.following = "\(json["following"] as? Int ?? 0)"
        user.publicRepos = "\(json["public_repos"] as? Int ?? 0)"

        return user
    }

    private static func cachePath() -> String {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documents + "/user_data_secure.bin"
    }

    private static func saveNonSensitiveDataToCache() {
        let nonSensitiveData = CurrentUserNonSensitive(
            token: currentUser.token,
            name: currentUser.name,
            avatarUrl: currentUser.avatarUrl,
            createdAt: currentUser.createdAt,
            updatedAt: currentUser.updatedAt,
            followers: currentUser.followers,
            publicGists: currentUser.publicGists,
            following: currentUser.following,
            publicRepos: currentUser.publicRepos
        )

        do {
            let jsonData = try JSONEncoder().encode(nonSensitiveData)
            if let encryptedData = CryptoUtils.encrypt(data: jsonData) {
                try encryptedData.write(to: URL(fileURLWithPath: cachePath()))
            }
        } catch {
            print("保存用户数据失败：\(error)")
        }
    }

    static func loadFromCache() {
        guard let encryptedData = try? Data(contentsOf: URL(fileURLWithPath: cachePath())),
              let decryptedData = CryptoUtils.decrypt(data: encryptedData) else {
            return
        }

        do {
            let nonSensitiveData = try JSONDecoder().decode(CurrentUserNonSensitive.self, from: decryptedData)
            currentUser.token = nonSensitiveData.token
            currentUser.name = nonSensitiveData.name
            currentUser.avatarUrl = nonSensitiveData.avatarUrl
            currentUser.createdAt = nonSensitiveData.createdAt
            currentUser.updatedAt = nonSensitiveData.updatedAt
            currentUser.followers = nonSensitiveData.followers
            currentUser.publicGists = nonSensitiveData.publicGists
            currentUser.following = nonSensitiveData.following
            currentUser.publicRepos = nonSensitiveData.publicRepos
        } catch {
            print("加载用户数据失败：\(error)")
        }
    }

    static func clearCache() {
        try? FileManager.default.removeItem(atPath: cachePath())
        currentUser = UserModel()
    }
}

extension UserModel {
    func isLoginSuccess() -> Bool {
        return token.count > 1
    }
}

private struct CurrentUserNonSensitive: Codable {
    let token: String
    let name: String
    let avatarUrl: String
    let createdAt: String
    let updatedAt: String
    let followers: String
    let publicGists: String
    let following: String
    let publicRepos: String
}
