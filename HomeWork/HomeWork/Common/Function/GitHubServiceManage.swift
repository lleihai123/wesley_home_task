//
//  GitHubServiceManage.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import Alamofire

public class HttpDataModel: NSObject {
    var code: Int32 = 0
    var errorMessage: String = ""
    var data: Any?

    init(code: Int32, errorMessage: String, data: Any? = nil) {
        self.code = code
        self.errorMessage = errorMessage
        self.data = data
    }
}

typealias HttpCallBack = (_ model: HttpDataModel) -> Void
protocol GitHubHttpInterface {
    func getToken(code: String, callback: HttpCallBack?)
    func getUser(token: String, callback: HttpCallBack?)
    func getSearch(kewWords: String, callback: HttpCallBack?)
    func getRepos(token: String, callback: HttpCallBack?)
}

class GitHubHttpInterfaceImpl: GitHubHttpInterface {
    func getToken(code: String, callback: HttpCallBack?) {
        let params: Parameters = [
            "client_id": AppConfig.gitHubClientId,
            "client_secret": AppConfig.gitHubSecret,
            "code": code]
        let headers: HTTPHeaders = [:]

        httpRequest(AppConfig.gitHubHomeURL + "login/oauth/access_token", method: .post, parameters: params, headers: headers, completionHandler: callback)
    }

    func getUser(token: String, callback: HttpCallBack?) {
        let params: Parameters = [:]
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        httpRequest(AppConfig.gitHubApiURL + "user", parameters: params, headers: headers, completionHandler: callback)
    }

    func getSearch(kewWords: String, callback: HttpCallBack?) {
        let params: Parameters = ["q": "\(kewWords)+language:iOS", "sorts": "stars", "order": "desc"]
        let headers: HTTPHeaders = [:]
        httpRequest(AppConfig.gitHubApiURL + "search/repositories", parameters: params, headers: headers, completionHandler: callback)
    }

    func getRepos(token: String, callback: HttpCallBack?) {
        let params: Parameters = [:]
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        httpRequest(AppConfig.gitHubApiURL + "user/repos", parameters: params, headers: headers, completionHandler: callback)
    }

    func httpRequest(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters:
        Parameters? = nil, headers: HTTPHeaders? = nil, completionHandler: HttpCallBack? = nil) {
        AF.request(convertible, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON { data in
                if let respData = data.data, respData.count > 0 {
                    if let value = try? JSONSerialization.jsonObject(with: respData, options: .mutableLeaves) {
                        completionHandler?(HttpDataModel(code: 0, errorMessage: "", data: value))
                        return
                    } else if let str = String(data: respData, encoding: .utf8) {
                        completionHandler?(HttpDataModel(code: 0, errorMessage: "", data: str))
                        return
                    }
                }
                completionHandler?(HttpDataModel(code: -1, errorMessage: AppLang("key_app_lang_parsing_failed"), data: nil))
            }
    }
}

class GitHubServiceManage {
    private var interface: GitHubHttpInterface
    private init(interface: GitHubHttpInterface) {
        self.interface = interface
    }

    static let shard: GitHubServiceManage = GitHubServiceManage(interface: GitHubHttpInterfaceImpl())
    var service: GitHubHttpInterface {
        return interface
    }

    static func configure(interface: GitHubHttpInterface) {
        GitHubServiceManage.shard.interface = interface
    }
}
