//
//  ErrorView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        VStack {
            200.h()
            Text(AppLang("key_app_lang_net_error_desc"))
                .font(.goMinera(14, .regular))
                .foregroundColor(.red)
            32.h()
            Button(action: {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventClick.systemSet, mainNeed: true))
            }, label: {
                Text(AppLang("key_app_lang_go_set"))
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
}
