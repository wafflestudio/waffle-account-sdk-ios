//
//  WebView.swift
//  WaffleAccountKit
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: View {
    
    public typealias OnSuccessLoginCallBack = (WaffleLoginDto) -> Void
    public typealias OnFailLoginCallBack = (Error?) -> Void
    
    @StateObject var coordinator: WebViewCoordinator
    @Environment(\.presentationMode) var presentationMode

    var url: URL
    
    public init(url: URL, onSuccessLogin: @escaping OnSuccessLoginCallBack, onFailLogin: @escaping OnFailLoginCallBack) {
        self.url = url
        self._coordinator = StateObject(wrappedValue: WebViewCoordinator(onSuccessLogin: onSuccessLogin,
                                                                         onFailLogin: onFailLogin))
    }

    public var body: some View {
        NavigationView {
            WebViewContainer(url: url, coordinator: coordinator)
                .overlay(
                    VStack {
                        makeProgressBar()
                        Spacer(minLength: 0)
                    }
                )
//                .navigationTitle(coordinator.title)
//                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        makeCloseToolbarItem()
                    }

                    ToolbarItemGroup(placement: .bottomBar) {
                        makeGoBackToolbarItem()
                        Spacer(minLength: 0)
                        makeRefreshToolbarItem()
                        Spacer(minLength: 0)
                        makeGoForwardToolbarItem()
                    }
                }
        }
    }
}

private extension WebView {
    func makeProgressBar() -> some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width * coordinator.progress, height: 2)
                .opacity(coordinator.progress < 1 ? 1 : 0)
        }
    }

    func makeCloseToolbarItem() -> some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
//            Image(uiImage: .icon.xmark)
//                .foregroundColor(.fds.gray500)
        }
    }

    func makeGoBackToolbarItem() -> some View {
        Button {
            coordinator.goBack()
        } label: {
//            Image(uiImage: .icon.chevronLeft)
//                .foregroundColor(coordinator.canGoBack ? .fds.gray500 : .fds.gray200)
        }
        .disabled(!coordinator.canGoBack)
    }

    func makeRefreshToolbarItem() -> some View {
        Button {
            coordinator.refresh()
        } label: {
//            Image(systemName: "arrow.clockwise") // TBD
//                .foregroundColor(coordinator.canRefresh ? .fds.gray500 : .fds.gray200)
        }
        .disabled(!coordinator.canRefresh)
    }

    func makeGoForwardToolbarItem() -> some View {
        Button {
            coordinator.goForward()
        } label: {
//            Image(uiImage: .icon.chevronRight)
//                .foregroundColor(coordinator.canGoForward ? .fds.gray500 : .fds.gray200)
        }
        .disabled(!coordinator.canGoForward)
    }
}
