//
//  NavigationTopView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import SwiftUI

struct NavigationTopView: View {
    static let leftDiff = 16
    static let rightDiff = 16

    let contentView: AnyView
    let color: Color
    init(contentView: AnyView, color: Color = .clear) {
        self.contentView = contentView
        self.color = color
    }

    var body: some View {
        VStack(spacing: 0) {
            UIDevice.statusBarHeight().h()
            contentView.frame(height: UIDevice.navigationBarHeight())
        }
        .frame(width: UIDevice.screenWidth(), height: UIDevice.navigationFullHeight())
        .background(color)
    }
}
