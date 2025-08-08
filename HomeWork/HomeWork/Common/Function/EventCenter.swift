//
//  EventCenter.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import Foundation

struct EventModel {
    var eventData: Any?
    var eventType: Any?
    var mainNeed: Bool = true
    init(eventData: Any? = nil,
         eventType: Any? = nil,
         mainNeed: Bool = false) {
        self.eventData = eventData
        self.eventType = eventType
        self.mainNeed = mainNeed
    }
}

protocol EventCenterInterface {
    func registerCallback(key: String, callback: @escaping EventBack)
    func unregisterCallback(key: String)
    func dispatcherEvent(event: EventModel)
}


typealias EventBack = (EventModel) -> Void
class EventCenter:EventCenterInterface {
    static let shard = EventCenter()

    private let lock = NSLock()
    private var blockMap: [String: EventBack] = [:]

    func registerCallback(key: String, callback: @escaping EventBack) {
        lock.lock()
        defer { lock.unlock() }
        blockMap[key] = callback
    }

    func unregisterCallback(key: String) {
        lock.lock()
        defer { lock.unlock() }
        blockMap.removeValue(forKey: key)
    }

    func dispatcherEvent(event: EventModel) {
        lock.lock()
        defer { lock.unlock() }
        let callbacks = Array(blockMap.values)
        if event.mainNeed {
            DispatchQueue.main.async {
                for callback in callbacks {
                    callback(event)
                }
            }
        } else {
            DispatchQueue.global().async {
                for callback in callbacks {
                    callback(event)
                }
            }
        }
    }
}
