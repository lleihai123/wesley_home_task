//
//  EventCenterMockInterface.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

class EventCenterMockInterface:EventCenterInterface {
    static let shard = EventCenterMockInterface()

    private var blockMap: [String: EventBack] = [:]

    func registerCallback(key: String, callback: @escaping EventBack) {
        blockMap[key] = callback
    }

    func unregisterCallback(key: String) {
        blockMap.removeValue(forKey: key)
    }

    func dispatcherEvent(event: EventModel) {
        for callback in blockMap.values {
            callback(event)
        }
    }
}
