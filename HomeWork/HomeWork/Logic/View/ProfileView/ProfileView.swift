//
//  ProfileView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var profileViewModel = ProfileViewModel()
    var body: some View {
        VStack {
            getTopView()
            if profileViewModel.isLoginSuccess {
                24.h()
                getUserInfoView()
                List {
                    getUserTimeInfoView()
                    getUserOtherInfoView()
                }.padding(16)
                24.h()
                getBottomView()
            } else {
                Spacer()
            }
            (UIDevice.safeDistanceBottom() + 100).h()
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

extension ProfileView {
    private func getTopView() -> some View {
        NavigationTopView(contentView: AnyView(navigationContentView()), color: NavigationTopViewBgColor(isDark: colorScheme == .dark))
    }

    private func navigationContentView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            Text(AppLang("key_app_lang_person"))
                .font(.goMinera(18, .bold))
                .foregroundColor(textColor).offset(x: 18)

            Spacer()
            Button(action: {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventClick.set, mainNeed: true))
            }) {
                Image(systemName: setImage)
            }
            .frame(width: 36, height: 36)
            16.w()
        }
    }

    private func getUserInfoView() -> some View {
        HStack(alignment: .top, spacing: 0) {
            Group {
                16.w()
                UIKitAsyncImageView(url: profileViewModel.userModel.avatarUrl)
                    .frame(width: 32, height: 32)
                    .clipped()
                    .clipShape(Circle())
                12.w()
                Text(profileViewModel.userModel.name)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                16.w()
            }
        }
    }

    private func getUserTimeInfoView() -> some View {
        VStack {
            16.h()
            HStack(alignment: .top, spacing: 0) {
                16.w()
                Text(AppLang("key_app_lang_user_create_time") + " : " + profileViewModel.userModel.createdAt)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                16.w()
            }.frame(height: 32)
            12.h()
            HStack(alignment: .top, spacing: 0) {
                16.w()
                Text(AppLang("key_app_lang_user_update_time") + " : " + profileViewModel.userModel.updatedAt)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                16.w()
            }.frame(height: 32)
            16.h()
        }
    }

    private func getUserOtherInfoView() -> some View {
        VStack {
            12.h()
            HStack {
                16.w()
                Text(AppLang("key_app_lang_user_public_gists") + " : " + profileViewModel.userModel.publicGists)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                12.w()
                Text(AppLang("key_app_lang_user_following") + " : " + profileViewModel.userModel.following)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                Spacer()
            }
            12.h()
            HStack {
                16.w()
                Text(AppLang("key_app_lang_user_followers") + " : " + profileViewModel.userModel.followers)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                12.w()
                Text(AppLang("key_app_lang_user_public_repos") + " : " + profileViewModel.userModel.publicRepos)
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textColor)
                Spacer()
            }
            12.h()
        }
    }

    private func getBottomView() -> some View {
        HStack {
            Button(action: {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventClick.logout, mainNeed: true))
            }, label: {
                Text(AppLang("key_app_lang_logout"))
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textButtonColor)
            })
            .frame(width: 112, height: 40)
            .background(buttonBgColor)
            .cornerRadius(20)
        }
    }

    private var textButtonColor: Color {
        return colorScheme == .dark ? 0x333333.color() : .white
    }

    private var buttonBgColor: Color {
        return colorScheme == .dark ? 0x0A84FF.color() : 0x007AFF.color()
    }

    private var textColor: Color {
        cellTextColor(isDark: colorScheme == .dark)
    }

    private var setImage: String {
        colorScheme == .dark ? "chart.bar.horizontal.page" : "chart.bar.horizontal.page.fill"
    }
}
