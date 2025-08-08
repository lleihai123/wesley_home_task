//
//  RepositoryCellView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct RepositoryCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    let data: RepositoryModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            12.h()
            topUserInfo()
            8.h()
            description()
            if data.topics?.count ?? 0 > 0 {
                8.h()
                getTopicsView()
            }
            12.h()
        }
        .background(bgColor)
    }
}

extension RepositoryCellView {
    func topUserInfo() -> some View {
        HStack(alignment: .center, spacing: 12) {
            UIKitAsyncImageView(url: data.avatarUrl ?? "")
                .frame(width: 32, height: 32)
                .clipped()
                .clipShape(Circle())

            Text(data.fullName ?? "")
                .font(.goMinera(14, .regular))
                .foregroundColor(textColor)

            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 8)
        .frame(height: 32)
    }

    func description() -> some View {
        HStack(alignment: .top, spacing: 0) {
            16.w()
            Text(data.description ?? "")
                .font(.goMinera(14, .regular))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            16.w()
        }
    }

    func getTopicsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                Spacer(minLength: 16)
                    .frame(height: 24)
                let array = data.topics ?? []
                ForEach(array, id: \.self) { topic in
                    Text(topic)
                        .font(.goMinera(14, .regular))
                        .foregroundColor(textColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(Color.random())
                        .cornerRadius(6)
                        .frame(height: 24)
                }
                Spacer(minLength: 10)
                    .frame(height: 24)
            }
            .frame(height: 24)
        }
        .frame(height: 24)
    }

    private var bgColor: Color {
        cellBgColor(isDark: colorScheme == .dark)
    }

    private var textColor: Color {
        cellTextColor(isDark: colorScheme == .dark)
    }
}
