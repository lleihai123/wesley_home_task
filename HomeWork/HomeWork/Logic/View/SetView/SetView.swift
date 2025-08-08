//
//  SetView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

import SwiftUI

struct SetView: View {
    var body: some View {
        VStack {
            List {
                SettingRow(
                    icon: "doc.text.magnifyingglass",
                    title: AppLang("key_app_lang_set_privacy"),
                    subtitle: AppLang("key_app_lang_set_privacy_detail"),
                )

                SettingRow(
                    icon: "shield.fill",
                    title: AppLang("key_app_lang_set_terms"),
                    subtitle: AppLang("key_app_lang_set_terms_detail"),
                )

                SettingRow(
                    icon: "tag.fill",
                    title: AppLang("key_app_lang_set_version"),
                    subtitle: "\(appVersion()) (\(buildNumber())"
                )
                .disabled(true)
            }
            .navigationTitle(AppLang("key_app_lang_set"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SettingRow: View {
    let icon: String
    let title: String
    let subtitle: String?

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.accentColor)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
