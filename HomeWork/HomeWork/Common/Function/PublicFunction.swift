//
//  PublicFunction.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//
import Foundation
import SwiftUI
import Toast_Swift
import ZLPhotoBrowser

internal func AppLang(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

internal func extractCode(from url: URL) -> String? {
    if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
       let queryItems = components.queryItems {
        return queryItems.first { $0.name == "code" }?.value
    }
    return nil
}

internal func extractParameter(from string: String, key: String) -> String? {
    // 按 "&" 分割成键值对
    let params = string.components(separatedBy: "&")
    // 遍历查找目标 key
    for param in params {
        let keyValue = param.components(separatedBy: "=")
        // 确保分割后有 key 和 value（处理空值情况，如 scope=）
        if keyValue.count >= 1 && keyValue[0] == key {
            // 如果有 value 则返回，否则返回空字符串
            return keyValue.count == 2 ? keyValue[1] : ""
        }
    }
    return nil
}

func addressKey(_ object: AnyObject) -> String {
    let identifier = ObjectIdentifier(object)
    return String(describing: identifier)
}

private var keyWindow: UIWindow {
    var keyWindow: UIWindow?
    for window in UIApplication.shared.windows {
        if window.isMember(of: UIWindow.self), window.isKeyWindow {
            keyWindow = window
            break
        }
    }
    return UIApplication.shared.windows.first ?? keyWindow!
}

func showToast(_ message: String) {
    if Thread.isMainThread {
        keyWindow.makeToast(message, position: .center)
    } else {
        DispatchQueue.main.async {
            showToast(message)
        }
    }
}

func showHud() -> ZLProgressHUD {
    let hud = ZLProgressHUD(style: .light)
    hud.show()
    return hud
}

func appVersion() -> String {
    guard let infoDict = Bundle.main.infoDictionary,
          let version = infoDict["CFBundleShortVersionString"] as? String else {
        return "1.0.0"
    }
    return version
}

func buildNumber() -> String {
    guard let infoDict = Bundle.main.infoDictionary,
          let build = infoDict["CFBundleVersion"] as? String else {
        return "1"
    }
    return build
}

func pageBgColor(isDark: Bool) -> Color {
    return isDark ? 0x121212.color() : 0xFFFFFF.color()
}

func cellBgColor(isDark: Bool) -> Color {
    return isDark ? 0x2C2C2E.color() : 0xF9FAFC.color()
}

func cellTextColor(isDark: Bool) -> Color {
    return isDark ? 0xECECEC.color() : 0x333333.color()
}

func NavigationTopViewBgColor(isDark: Bool) -> Color {
    return isDark ? 0x1C1C1E.color() : 0xF5F7FA.color()
}

func tabBgColor(isDark: Bool) -> UIColor {
    return isDark ? UIColor.rgb(hex: 0x121212) : UIColor.rgb(hex: 0xFFFFFF)
}
