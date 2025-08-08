//
//  RootViewModel.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import Network
import SwiftUI

public class RootViewModel: ObservableObject {
    @Published var selectedTab = 0
    @Published var isNeedLogin = false
    @Published var isNetError = false
    @Published var isNeedLogOut = false
    @Published var isNeedShowingSettings = false
    let eventCenter:EventCenterInterface
    var ignoreTabSwitch = false

    private lazy var monitor: NWPathMonitor = {
        var monitor = NWPathMonitor()
        return monitor
    }()

    init(eventCenter:EventCenterInterface = EventCenter.shard) {
        self.eventCenter = eventCenter
        initData()
        addObserver()
    }

    deinit {
        eventCenter.unregisterCallback(key: self.key)
    }

    func isLoginSuccess() -> Bool {
        UserModel.getCurrentUser().isLoginSuccess()
    }

    func initData() {
        UserModel.loadFromCache()
    }
}

extension RootViewModel {
    func addObserver() {
        eventCenter.registerCallback(key: key) { [weak self] model in
            guard let self = self else { return }
            if let type = model.eventType as? AppEventType {
                switch type {
                case .networkSuccess:
                    self.isNetError = false
                case .networkError:
                    self.isNetError = true
                case .getUserSuccess:
                    self.selectedTab = 1
                default:
                    break
                }
            } else if let type = model.eventType as? AppEventClick {
                switch type {
                case .systemSet:
                    self.goSettings()
                case .logout:
                    self.isNeedLogOut = true
                case .set:
                    self.isNeedShowingSettings = true
                default:
                    break
                }
            } else if let type = model.eventType as? AppUserStateEvent {
                switch type {
                case .logoutSuccess:
                    self.ignoreTabSwitch = true
                    self.selectedTab = 0
                }
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.networkSuccess, mainNeed: true))
            } else {
                EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.networkError, mainNeed: true))
            }
        }
        monitor.start(queue: queue)
    }

    func goSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
}
