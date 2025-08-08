//
//  AlertBgView.swift
//  HomeWork
//
//  Created by WesleyLei on 2025/8/7.
//

import SwiftUI

public protocol AlertBgViewProtocol: View {
    func isSupportTouchToExit() -> Bool
    mutating func setViewModel(viewModel: AlertViewModel)
}

public extension AlertBgViewProtocol {
    func isSupportTouchToExit() -> Bool {
        return false
    }

    mutating func setViewModel(viewModel: AlertViewModel) {
    }
}

public class AlertViewModel: ObservableObject {
    @Published var bgColorOpacity = 0.0
    var finishDismissBlock: (() -> Void)?
    var presentationMode: Binding<PresentationMode>?
    var animationDuration: CGFloat = 0.5

    public func dismiss(object: Any? = nil, finishDismissBlock: (() -> Void)? = nil) {
        self.finishDismissBlock = finishDismissBlock
        UIDevice.hiddenKeyBoard()
        let customAnimation = Animation.easeInOut(duration: animationDuration)
        withAnimation(customAnimation) {
            self.bgColorOpacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { [weak self] in
            self?.presentationMode?.wrappedValue.dismiss()
        }
    }
}

public struct AlertBgView: View {
    @ObservedObject var viewModel = AlertViewModel()
    @Environment(\.presentationMode) var presentationMode
    private var contentView: any AlertBgViewProtocol
    private let topDiff: CGFloat
    private let bgColor: Color

    public init(contentView: any AlertBgViewProtocol,
                topDiff: CGFloat,
                animationDuration: CGFloat = 0.5) {
        self.contentView = contentView
        self.topDiff = topDiff
        bgColor = 0x000000.color(0.6)
        viewModel.animationDuration = animationDuration
        self.contentView.setViewModel(viewModel: viewModel)
    }

    public var body: some View {
        ZStack(alignment: .top) {
            // MARK: 背景色

            bgColor
                .opacity(viewModel.bgColorOpacity).edgesIgnoringSafeArea(.all)

            // MARK: 内容页

            VStack(spacing: 0) {
                topDiff.h()
                getContentView()
            }
        }
        .onAppear {
            viewModel.presentationMode = self.presentationMode
            let customAnimation = Animation.easeInOut(duration: viewModel.animationDuration)
            withAnimation(customAnimation) {
                viewModel.bgColorOpacity = 1.0
            }
        }
        .onTapGesture {
            if contentView.isSupportTouchToExit() {
                dismiss()
            }
        }
        .onDisappear(perform: viewModel.finishDismissBlock)
    }

    func dismiss(object: Any? = nil) {
        viewModel.dismiss(object: object)
    }
}

extension AlertBgView {
    private func getContentView() -> some View {
        return AnyView(contentView)
    }
}
