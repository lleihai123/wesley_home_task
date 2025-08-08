//
//  ProfileViewModel.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

public class ProfileViewModel: ObservableObject {
    @Published var isLoginSuccess = false
    let eventCenter:EventCenterInterface
    var userModel: UserModel {
        UserModel.getCurrentUser()
    }

    init(eventCenter:EventCenter = EventCenter.shard) {
        self.eventCenter = eventCenter
        initData()
        addObserver()
    }

    func initData() {
        isLoginSuccess = userModel.isLoginSuccess()
    }
    deinit {
        eventCenter.unregisterCallback(key: self.key)
    }
}

extension ProfileViewModel {
    func addObserver() {
        eventCenter.registerCallback(key: key) { [weak self] model in
            guard let self = self else { return }
            if let type = model.eventType as? AppEventType {
                switch type {
                case .gitHubAuth:
                    if let code = model.eventData as? String {
                        self.getToken(code: code)
                    }
                case .getTokenSuccess:
                    if let token = model.eventData as? String {
                        self.getUser(token: token)
                    }
                case .getUserSuccess:
                    isLoginSuccess = true
                default:
                    break
                }
            } else if let type = model.eventType as? AppEventClick {
                switch type {
                case .login:
                    self.login()
                case .logoutConfirm:
                    self.logout()
                default:
                    break
                }
            }
        }
    }

    func login() {
        guard let authUrl = URL(string: AppConfig.gitHubAuthUrl) else { return }
        UIApplication.shared.open(authUrl, options: [:], completionHandler: nil)
    }

    func logout() {
        UserModel.clearCache()
        isLoginSuccess = false
        EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppUserStateEvent.logoutSuccess, mainNeed: true))
    }

    func getToken(code: String) {
        GitHubServiceManage.shard.service.getToken(code: code) { model in
            if model.code == 0, let str = model.data as? String, let token = extractParameter(from: str, key: "access_token") {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: token, eventType: AppEventType.getTokenSuccess))
            } else {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: code, eventType: AppEventType.getTokenFail, mainNeed: true))
                showToast(AppLang("key_app_lang_auth_login_error"))
            }
        }
    }

    func getUser(token: String) {
        GitHubServiceManage.shard.service.getUser(token: token) { model in
            if model.code == 0, let json = model.data as? [String: Any] {
                let user = UserModel.createUser(json: json, token: token)
                UserModel.updateCurrentUser(user: user)
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: user, eventType: AppEventType.getUserSuccess, mainNeed: true))
                showToast(AppLang("key_app_lang_auth_login_success"))
            } else {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.getUserFail, mainNeed: true))
            }
        }
    }
}
