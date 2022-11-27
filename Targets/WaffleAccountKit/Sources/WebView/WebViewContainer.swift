//
//  WebViewContainer.swift
//  WaffleAccountKit
//
//  Created by parksubeen on 2022/11/26.
//  Copyright © 2022 com.wafflestudio. All rights reserved.
//

import Combine
import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    var url: URL
    var coordinator: WebViewCoordinator

    func makeUIView(context: Context) -> UIViewType {
        let uiView =  UIViewType()
        coordinator.bind(uiView)
        return uiView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.url.send(url)
    }

    final class UIViewType: UIView {
        let url = PassthroughSubject<URL, Never>()
        let webView = CurrentValueSubject<WKWebView?, Never>(nil)
        let refresh = CurrentValueSubject<Void, Never>(())

        private var cancellables: Set<AnyCancellable> = []
        private var task: Task<Void, Never>?

        override init(frame: CGRect = .zero) {
            super.init(frame: frame)

            task?.cancel()
            task = Task { [weak self] in
                let configuration = WKWebViewConfiguration()

                await MainActor.run { [weak self] in
                    self?.setUpWebView(configuration: configuration)
                }
            }

            Publishers.CombineLatest3(webView.compactMap { $0 }, url, refresh)
                .sink { webView, url, _ in
                    webView.load(.init(url: url))
                }
                .store(in: &cancellables)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setUpWebView(configuration: WKWebViewConfiguration) {
            
            let contentController = WKUserContentController()
            configuration.userContentController = contentController
            
            let webView = WKWebView(frame: .zero, configuration: configuration)
            addSubview(webView)
            
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
            webView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true

            self.webView.send(webView)
        }
        
    }
}
