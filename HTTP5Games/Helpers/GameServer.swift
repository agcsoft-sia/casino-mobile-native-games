//
//  GameServer.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import Foundation
import GCDWebServers

class GameServer {
    static let shared = GameServer()

    func start(
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
            let url: URL! = URL(string: "http://127.0.0.1:8081?startup=\(session)")
            return url
        }
    
    func stop() {
        server?.stop()
        server = nil
    }
    
    private var server: GCDWebServer!
}
