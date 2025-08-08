//
//  BackgroundClearView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

import SwiftUI
import UIKit

public struct BackgroundClearView: UIViewRepresentable {
    public init() {}

    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        // 延迟获取父视图（确保层级已构建完成）
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            clearSuperviewBackground(of: view)
        }
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        clearSuperviewBackground(of: uiView)
    }

    // 递归查找并清除父视图背景
    private func clearSuperviewBackground(of view: UIView) {
        var currentView: UIView? = view
        // 向上查找3层父视图（适配不同系统版本的层级差异）
        for _ in 0 ..< 3 {
            currentView = currentView?.superview
            currentView?.backgroundColor = .clear
            currentView?.isOpaque = false // 关键：关闭不透明属性
            currentView?.layer.removeAllAnimations()
        }
    }
}
