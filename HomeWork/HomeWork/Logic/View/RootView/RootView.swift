//
//  RootView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct RootView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var rootViewModel = RootViewModel()

    var body: some View {
        NavigationView {
            if rootViewModel.isNetError {
                getErrorView()
            } else {
                getContentView()
            }
        }
    }
}

extension RootView {
    private func getErrorView() -> some View {
        ErrorView()
    }

    private func getContentView() -> some View {
        TabView(selection: $rootViewModel.selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(AppLang("key_app_lang_home"))
                }
                .tag(0)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(AppLang("key_app_lang_person"))
                }
                .tag(1)
        }
        .overlay(
            NavigationLink(
                destination: SetView(),
                isActive: $rootViewModel.isNeedShowingSettings,
                label: { EmptyView() }
            )
        )
        .onChange(of: rootViewModel.selectedTab) { _ in
            if !rootViewModel.isLoginSuccess() && !rootViewModel.ignoreTabSwitch {
                rootViewModel.selectedTab = 0
                rootViewModel.isNeedLogin = true
            }
            rootViewModel.ignoreTabSwitch = false
        }
        .accentColor(.blue)
        .fullScreenCover(isPresented: $rootViewModel.isNeedLogin) {
            LoginView()
        }.fullScreenCover(isPresented: $rootViewModel.isNeedLogOut) {
            LogoutConfirmView()
        }.onAppear {
            setupOpaqueTabBar()
        }
    }

    private func setupOpaqueTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = tabBgColor(isDark: colorScheme == .dark)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UITabBar.appearance().barTintColor = .white
            UITabBar.appearance().isTranslucent = false
        }
    }
}
