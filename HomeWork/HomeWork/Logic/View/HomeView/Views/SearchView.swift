//
//  SearchView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct HomeTopView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            16.w()
            TextField(AppLang("key_app_lang_place_holder"), text: $viewModel.kewWords).onChange(of: viewModel.kewWords, perform: { newValue in
                let maxLength = 50
                if newValue.count > maxLength {
                    $viewModel.kewWords.wrappedValue = String(newValue.prefix(maxLength))
                }
            })
            .font(.goMinera(16, .regular))
            .foregroundColor(textFieldColor)
            .padding(.all, 6)
            .background(textFieldBgColor)

            10.w()

            Button(action: {
                viewModel.search()
            }) {
                Image(systemName: searchImage)
            }
            .frame(width: 36, height: 36)
            16.w()
        }
    }
}

extension HomeTopView {
    private var textFieldColor: Color {
        cellTextColor(isDark: colorScheme == .dark)
    }

    private var textFieldBgColor: Color {
        return colorScheme == .dark ? 0x2C2C2E.color() : 0xF2F2F2.color()
    }

    private var searchImage: String {
        colorScheme == .dark ? "magnifyingglass.circle.fill" : "magnifyingglass"
    }
}
