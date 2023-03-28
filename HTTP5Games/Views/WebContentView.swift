//
//  WebContentView.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import SwiftUI
import WebKit
import Combine

protocol WebContentViewModelProtocol {
    var url: URL? { get }
}

struct WebContentViewModel: WebContentViewModelProtocol {
    private(set) var url: URL?

    init(url: URL?) {
        guard let url = url,
              var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            self.url = url
            return
        }

        var queryItems = urlComps.queryItems ?? []
        queryItems.append(URLQueryItem(name: "webView", value: "true"))
        urlComps.queryItems = queryItems
        self.url = urlComps.url
    }
}

struct WebContentView: View {

    private var viewModel: WebContentViewModelProtocol
    private weak var navigationDelegate: WKNavigationDelegate?
    private weak var uiDelegate: WKUIDelegate?
    private var shouldSignalEnvironment: Bool

    init(viewModel: WebContentViewModelProtocol,
         navigationDelegate: WKNavigationDelegate? = nil,
         uiDelegate: WKUIDelegate? = nil,
         shouldSignalEnvironmentOnAppear: Bool = true) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.uiDelegate = uiDelegate
        self.shouldSignalEnvironment = shouldSignalEnvironmentOnAppear
    }

    var body: some View {
        WebView(url: viewModel.url,
                navigationDelegate: navigationDelegate,
                uiDelegate: uiDelegate)
            .navigationBarHidden(false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: .bottom)
    }
}

