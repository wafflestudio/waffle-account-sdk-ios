//
//  WebViewCoordinator.swift
//  WaffleAccountKit
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import WebKit

final class WebViewCoordinator: NSObject, ObservableObject, WKNavigationDelegate {
    
    public typealias OnSuccessLoginCallBack = (WaffleLoginDto) -> Void
    public typealias OnFailLoginCallBack = (Error?) -> Void

    @Published var progress: CGFloat = 0
    @Published var canRefresh: Bool = false
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false

    private weak var uiView: WebViewContainer.UIViewType?
    private weak var webView: WKWebView?

    private var cancellables: Set<AnyCancellable> = []
    private var observation: NSKeyValueObservation?
    
    var onSuccessLogin: OnSuccessLoginCallBack
    var onFailLogin: OnFailLoginCallBack
    
    public init(onSuccessLogin: @escaping OnSuccessLoginCallBack, onFailLogin: @escaping OnFailLoginCallBack) {
        self.onSuccessLogin = onSuccessLogin
        self.onFailLogin = onFailLogin
    }

    deinit {
        observation = nil
    }

    func bind(_ uiView: WebViewContainer.UIViewType) {
        uiView.webView
            .compactMap { $0 }
            .sink { [weak self] webView in
                
                guard let self else { return }
                
                webView.navigationDelegate = self
                webView.configuration.userContentController.add(self, name: .onSuccessSingIn)

                self.webView = webView

                self.observation = webView.observe(\.estimatedProgress, options: .new) { [weak self] _, changes in
                    withAnimation {
                        changes.newValue.map { self?.progress = $0 }
                    }
                }
            }
            .store(in: &cancellables)

        self.uiView = uiView
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        canRefresh = false
        canGoBack = false
        canGoForward = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        canRefresh = true
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        canRefresh = true
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
    }

}

extension WebViewCoordinator {
    func refresh() {
        uiView?.refresh.send(())
    }

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }
}

extension WebViewCoordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        #if DEBUG
        print("MESSAGE RECEIVED \(message.body)")
        #endif
        if message.name == .onSuccessSingIn {
            handleOnSuccessLogIn(messageBody: message.body)
        }
    }
}

private extension WebViewCoordinator {
    func handleOnSuccessLogIn(messageBody: Any) {
        
        if let token = messageBody as? String {
            onSuccessLogin(.init(token: token, expireAt: nil))
            return
        }
        
        if let payload = messageBody as? [String: String],
            let token = payload["token"],
            let expireAt = payload["expire_at"] {
            onSuccessLogin(.init(token: token, expireAt: expireAt))
            return
        }

    }
}
