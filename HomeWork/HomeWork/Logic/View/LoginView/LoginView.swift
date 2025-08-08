//
//  LoginView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

import SwiftUI

struct LoginViewContentView: AlertBgViewProtocol {
    @Environment(\.colorScheme) private var colorScheme
    private var viewModel: AlertViewModel?

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                getContentView()
            }
        }.frame(height: 280)
    }

    mutating func setViewModel(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}

extension LoginViewContentView {
    private func getContentView() -> some View {
        VStack(spacing: 0) {
            56.h()
            getContentTitle()
            16.h()
            getContentDesc()
            32.h()
            getContentBottomButtons()
            42.h()
        }
        .frame(width: 280)
        .background(contentViewBgColor)
        .cornerRadius(16)
    }

    private func getContentTitle() -> some View {
        Text(AppLang("key_app_lang_remind_tips"))
            .font(.goMinera(18, .bold))
            .foregroundColor(textColor)
    }

    private func getContentDesc() -> some View {
        Text(AppLang("key_app_lang_auth_login_desc"))
            .font(.goMinera(16, .regular))
            .foregroundColor(textColor)
    }

    private func getContentBottomButtons() -> some View {
        HStack {
            16.w()
            Button(action: {
                dismiss()
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventClick.login, mainNeed: true))
            }, label: {
                Text(AppLang("key_app_lang_auth_login"))
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textButtonColor)
            })
            .frame(width: 112, height: 40)
            .background(buttonBgColor)
            .cornerRadius(20)

            Spacer()

            Button(action: {
                dismiss()
            }, label: {
                Text(AppLang("key_app_lang_cancel"))
                    .font(.goMinera(14, .regular))
                    .foregroundColor(textCancelButtonColor)
            })
            .font(.goMinera(14, .regular))
            .frame(width: 112, height: 40)
            .background(cancelButtonBgColor)
            .cornerRadius(20)
            .opacity(0.9)
            16.w()
        }
    }

    private func dismiss(object: Any? = nil) {
        viewModel?.dismiss(object: object)
    }

    private var textButtonColor: Color {
        return colorScheme == .dark ? 0x333333.color() : .white
    }

    private var buttonBgColor: Color {
        return colorScheme == .dark ? 0x0A84FF.color() : 0x007AFF.color()
    }

    private var textCancelButtonColor: Color {
        return colorScheme == .dark ? 0xF2F2F7.color() : 0x3A3A3C.color()
    }

    var cancelButtonBgColor: Color {
        return colorScheme == .dark ? 0x3A3A3C.color() : 0xF2F2F7.color()
    }

    private var textColor: Color {
        return colorScheme == .dark ? 0xECECEC.color() : 0x333333.color()
    }

    private var contentViewBgColor: Color {
        colorScheme == .dark ? 0x4F4F4F.color() : 0xC1C1C1.color()
    }
}

struct LoginView: View {
    var body: some View {
        AlertBgView(contentView: LoginViewContentView(), topDiff: UIDevice.statusBarHeight() - 44 + 170)
            .background(BackgroundClearView())
    }
}
