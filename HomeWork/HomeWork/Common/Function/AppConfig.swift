//
//  Config.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

class AppConfig {
    static var gitHubApiURL: String {
        #if DEBUG
            return "https://api.github.com/"
        #else
            return "https://api.github.com/"
        #endif
    }

    static var gitHubClientId: String {
        #if DEBUG
            return "Ov23liMyfDrcGaDsXrAb"
        #else
            return "Ov23liMyfDrcGaDsXrAb"
        #endif
    }

    static var gitHubSecret: String {
        #if DEBUG
            return "f5859a8ddfb3d056a9d4130ac3b3a8d9f0fe483d"
        #else
            return "f5859a8ddfb3d056a9d4130ac3b3a8d9f0fe483d"
        #endif
    }

    static var gitHubCallbackURL: String {
        #if DEBUG
            return "github://wesleyLoginCallback"
        #else
            return "github://wesleyLoginCallback"
        #endif
    }

    static var gitHubHomeURL: String {
        return "https://github.com/"
    }

    static var gitHubAuthUrl: String {
        func generateRandom5DigitString() -> String {
            let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            let charactersArray = Array(characters)
            var result = ""
            for _ in 0 ..< 5 {
                let randomIndex = Int.random(in: 0 ..< charactersArray.count)
                result.append(charactersArray[randomIndex])
            }
            return result
        }
        let randomStr = generateRandom5DigitString()
        return gitHubHomeURL + "login/oauth/authorize" + "?client_id=\(gitHubClientId)" + "&state=\(randomStr)" + "&redirect_uri=\(gitHubCallbackURL)"
    }
}
