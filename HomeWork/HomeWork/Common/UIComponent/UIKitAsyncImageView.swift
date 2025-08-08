//
//  UIKitAsyncImageView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/6.
//

import Kingfisher
import SwiftUI

struct UIKitAsyncImageView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.kf.setImage(with: URL(string: url))
    }
}
