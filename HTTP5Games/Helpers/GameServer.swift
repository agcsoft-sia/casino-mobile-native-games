//
//  GameServer.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import Foundation
import GCDWebServers

enum GameProvider {
    case habanero
    case pragmaticplay
}

class GameServer {
    static let shared = GameServer()

    func start(
        provider: GameProvider,
        directoryPath: URL,
        indexFilename: String,
        session: String) -> URL {
            let server = GCDWebServer()
            server.addGETHandler(
                forBasePath: "/",
                directoryPath: directoryPath.path,
                indexFilename: indexFilename,
                cacheAge: 0,
                allowRangeRequests: true
            )
            server.start(withPort: 8081, bonjourName: nil)
            self.server = server
            
            switch provider {
            case .pragmaticplay:
                let launcherURL: URL! = server.serverURL?.appendingPathComponent("launcher.html")
                var components = URLComponents(url: launcherURL, resolvingAgainstBaseURL: true)
                var queryItems = components?.percentEncodedQueryItems ?? []
                queryItems.append(.init(name: "url", value: session))
                components?.percentEncodedQueryItems = queryItems
                let url = components!.url!
                return url
            case .habanero:
                let launcherURL: URL! = server.serverURL?.appendingPathComponent("index.html")
                var components = URLComponents(url: launcherURL, resolvingAgainstBaseURL: true)
                var queryItems = components?.percentEncodedQueryItems ?? []
                queryItems.append(.init(name: "startup", value: session))
                components?.percentEncodedQueryItems = queryItems
                let url = components!.url!
                return url
            }
        }
    
    func stop() {
        server?.stop()
        server = nil
    }
    
    private var server: GCDWebServer!
}
