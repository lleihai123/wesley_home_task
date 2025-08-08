//
//  extension.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI
import SwiftUICore

extension Color {
    init(rgb: Int, alpha: CGFloat = 1.0) {
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0xFF00) >> 8) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }

    static func rgb(hex: Int, alpha: CGFloat = 1.0) -> Color {
        return Color(rgb: hex, alpha: alpha)
    }

    static func random() -> Color {
        let red = Double.random(in: 0 ... 1)
        let green = Double.random(in: 0 ... 1)
        let blue = Double.random(in: 0 ... 1)
        return Color(red: red, green: green, blue: blue)
    }
}

extension UIColor {
    static func rgb(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}

extension Double {
    func h() -> some View {
        Spacer().frame(height: self)
    }

    func w() -> some View {
        Spacer().frame(width: self)
    }
}

extension CGFloat {
    func h() -> some View {
        Spacer().frame(height: self)
    }

    func w() -> some View {
        Spacer().frame(width: self)
    }
}

extension Int {
    func h() -> some View {
        CGFloat(self).h()
    }

    func w() -> some View {
        CGFloat(self).w()
    }

    func color(_ alpha: CGFloat = 1.0) -> Color {
        .rgb(hex: self, alpha: alpha)
    }
}

enum CustomUIFontType {
    case light
    case bold
    case regular
}

extension Font {
    static func goMinera(_ size: CGFloat, _ weight: CustomUIFontType = .light) -> Font {
        switch weight {
        case .regular:
            return Font.custom("Outfit-Regular", size: size)
        case .bold:
            return Font.custom("Outfit-Bold", size: size)
        case .light:
            return Font.custom("Outfit-Light", size: size)
        }
    }
}

public extension UIDevice {
    private static let gScreenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    private static let gScreenHeight = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)

    static func safeDistanceTop() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.top
        }
        return 0
    }

    /// 底部安全区高度
    static func safeDistanceBottom() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        }
        return 0
    }

    /// 顶部状态栏高度（包括安全区）
    static func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    class func screenWidth() -> CGFloat {
        return gScreenWidth
    }

    class func screenHeight() -> CGFloat {
        return gScreenHeight
    }

    /// 导航栏高度
    static func navigationBarHeight() -> CGFloat {
        return 44.0
    }

    /// 状态栏+导航栏的高度
    static func navigationFullHeight() -> CGFloat {
        return UIDevice.statusBarHeight() + UIDevice.navigationBarHeight()
    }

    /// 底部导航栏高度
    static func tabBarHeight() -> CGFloat {
        return 80.0 - UIDevice.safeDistanceBottom()
    }

    /// 底部导航栏高度（包括安全区）
    static func tabBarFullHeight() -> CGFloat {
        return UIDevice.tabBarHeight() + UIDevice.safeDistanceBottom()
    }

    // 关闭键盘
    static func hiddenKeyBoard() {
        let resignFirstResponder = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resignFirstResponder, to: nil, from: nil, for: nil)
    }
}

extension ObservableObject {
    var key: String {
        addressKey(self)
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
