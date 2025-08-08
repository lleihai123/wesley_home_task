//
//  ContentView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            homeContentView()
            homeSearchTop()
        }
        .background(pageBgColor(isDark: colorScheme == .dark))
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

extension HomeView {
    private func homeSearchTop() -> some View {
        NavigationTopView(contentView: AnyView(HomeTopView(viewModel: viewModel)), color: NavigationTopViewBgColor(isDark: colorScheme == .dark))
    }

    private func homeContentView() -> some View {
        return ScrollView {
            (UIDevice.navigationFullHeight() + 16).h()
            let array = viewModel.listData
            LazyVStack(spacing: 12) {
                ForEach(array) { data in
                    RepositoryCellView(data: data)
                }
            }
            UIDevice.tabBarFullHeight().h()
        }
    }
}
