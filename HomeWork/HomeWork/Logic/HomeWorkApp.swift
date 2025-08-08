//
//  HomeWorkApp.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

@main
struct HomeWorkApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL(perform: { incomingURL in
                    guard let code = extractCode(from: incomingURL) else {
                        showToast("key_app_lang_login_failed")
                        return
                    }
                    EventCenter.shard.dispatcherEvent(event: EventModel(eventData: code, eventType: AppEventType.gitHubAuth))
                })
        }
    }
}
