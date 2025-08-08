//
//  HomeViewModel.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import ObjectMapper
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var kewWords: String = ""
    @Published var listData: [RepositoryModel] = []
    let eventCenter:EventCenterInterface
    var userModel: UserModel {
        UserModel.getCurrentUser()
    }

    init(eventCenter:EventCenter = EventCenter.shard) {
        self.eventCenter = eventCenter
        initData()
        addObserver()
    }

    deinit {
        eventCenter.unregisterCallback(key: self.key)
    }
}

extension HomeViewModel {
    func addObserver() {
        eventCenter.registerCallback(key: key) { [weak self] model in
            guard let self = self else { return }
            if let type = model.eventType as? AppEventType {
                switch type {
                case .getUserSuccess:
                    self.initData()
                default:
                    break
                }
            } else if let type = model.eventType as? AppUserStateEvent {
                switch type {
                case .logoutSuccess:
                    self.initData()
                }
            }
        }
    }

    func search() {
        UIDevice.hiddenKeyBoard()
        if kewWords.count <= 0 {
            showToast(AppLang("key_app_lang_error_input"))
            return
        }
        httpSearchData(kewWords: kewWords)
        kewWords = ""
    }

    func httpSearchData(kewWords: String) {
        debugPrint("------ kewWords: \(kewWords)")
        let hud = showHud()
        GitHubServiceManage.shard.service.getSearch(kewWords: kewWords) { [weak self] model in
            defer {
                hud.hide()
            }
            if model.code == 0, let map = model.data as? [String: Any], let items = map["items"] as? [[String: Any]] {
                if let list = Mapper<RepositoryModel>().mapArray(JSONObject: items) {
                    DispatchQueue.main.async {
                        self?.updateData(list: list)
                    }
                }
            } else {
                showToast(AppLang("key_app_lang_http_error_search"))
            }
        }
    }

    func httpSelfData() {
        let hud = showHud()
        GitHubServiceManage.shard.service.getRepos(token: userModel.token) { [weak self] model in
            defer {
                hud.hide()
            }
            if model.code == 0, let items = model.data as? [Any] {
                if let list = Mapper<RepositoryModel>().mapArray(JSONObject: items) {
                    DispatchQueue.main.async {
                        self?.updateData(list: list)
                    }
                }
            } else {
                showToast(AppLang("key_app_lang_http_error_search"))
            }
        }
    }

    func initData() {
        if userModel.isLoginSuccess() {
            httpSelfData()
        } else {
            httpSearchData(kewWords: "swift")
        }
    }

    func updateData(list: [RepositoryModel]) {
        listData = list
    }
}
