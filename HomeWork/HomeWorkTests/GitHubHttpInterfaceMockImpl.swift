//
//  Mock.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//


class GitHubHttpInterfaceMockImpl: GitHubHttpInterface {
    func getToken(code: String, callback: HttpCallBack?) {
        let dataModel =  HttpDataModel(code: 0,errorMessage: "",data: nil)
        callback?(dataModel)
    }

    func getUser(token: String, callback: HttpCallBack?) {
        let dataModel =  HttpDataModel(code: 0,errorMessage: "",data: nil)
        callback?(dataModel)
    }

    func getSearch(kewWords: String, callback: HttpCallBack?) {
        let dataModel =  HttpDataModel(code: 0,errorMessage: "",data: nil)
        callback?(dataModel)
    }

    func getRepos(token: String, callback: HttpCallBack?) {
        let dataModel =  HttpDataModel(code: 0,errorMessage: "",data: nil)
        callback?(dataModel)
    }

}
