//
//  Enum.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

enum ViewRoute: Hashable {
    case home
    case login
    case profile
    case search
    case about
    case set
}

enum AppEventType: Hashable {
    case networkSuccess
    case networkError
    case gitHubAuth
    case getTokenSuccess
    case getTokenFail
    case getUserSuccess
    case getUserFail
}

enum AppEventClick: Hashable {
    case login
    case systemSet
    case logout
    case logoutConfirm
    case set
}

enum AppUserStateEvent: Hashable {
    case logoutSuccess
}
