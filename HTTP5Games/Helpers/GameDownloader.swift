//
//  GameDownloader.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import Foundation

enum GameDownloaderError: Error {
    case gameArchPathIsInvalid(String)
    
    var localizedDescription: String {
        switch self {
        case .gameArchPathIsInvalid(let name):
            return "gameArchPathIsInvalid: \(name)"
        }
    }
}

class GameDownloader {
    static let shared = GameDownloader()
    
    private init() {}
    
    func donwload(tag: String, archName: String) async throws -> URL {
        let request = NSBundleResourceRequest(tags: [tag], bundle: .main)
        let access = await request.conditionallyBeginAccessingResources()
        if !access {
            try await request.beginAccessingResources()
        }
        
        guard let gameArchPath = Bundle.main.url(forResource: archName, withExtension: nil) else {
            throw GameDownloaderError.gameArchPathIsInvalid(archName)
        }
        
        return gameArchPath
    }
}
