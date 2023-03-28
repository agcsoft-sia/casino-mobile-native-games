//
//  WebView.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import UIKit
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    weak var navigationDelegate: WKNavigationDelegate?
    weak var uiDelegate: WKUIDelegate?
    let bounces: Bool

    init?(
        url: URL?,
        navigationDelegate: WKNavigationDelegate?,
        uiDelegate: WKUIDelegate?,
        bounces: Bool = false
    ) {
        guard let url = url else { return nil }
        self.request = URLRequest(url: url)
        self.navigationDelegate = navigationDelegate
        self.uiDelegate = uiDelegate
        self.bounces = bounces
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        configuration.websiteDataStore = .nonPersistent()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = navigationDelegate
        webView.scrollView.bounces = bounces
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = navigationDelegate
        uiView.uiDelegate = uiDelegate
        if context.coordinator.request != request {
            uiView.load(request)
            context.coordinator.request = request
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var request: URLRequest?
    }
}

