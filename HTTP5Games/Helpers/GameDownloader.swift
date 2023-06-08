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

class GameDownloadProgress: NSObject {
    init(handler: @escaping (Double) -> Void) {
        self.handler = handler
        super.init()
    }
    var context: UnsafeMutableRawPointer!
    var handler: ((Double) -> Void)?
    
    override func observeValue(forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {

      if context == context
        && keyPath == "fractionCompleted" {

          handler?((object as? Progress)?.fractionCompleted ?? 0)
      }
    }
}

class GameDownloader {
    static let shared = GameDownloader()
    
    private init() {}
    
    func donwload(
        tag: String,
        archName: String,
        progressObserver: GameDownloadProgress?
    ) async throws -> URL {
        self.progressObserver = progressObserver
        self.request = NSBundleResourceRequest(tags: [tag], bundle: .main)
        if let progressObserver = progressObserver {
            request.progress.addObserver(
                progressObserver,
                forKeyPath: "fractionCompleted",
                options: [.new, .initial],
                context: progressObserver.context)
        }
        let access = await request.conditionallyBeginAccessingResources()
        if !access {
            try await request.beginAccessingResources()
        }
        
        guard let gameArchPath = Bundle.main.url(forResource: archName, withExtension: nil) else {
            throw GameDownloaderError.gameArchPathIsInvalid(archName)
        }
        
        return gameArchPath
    }
    
    func stop() {
        if let progressObserver = progressObserver {
          request.progress.removeObserver(progressObserver,
            forKeyPath: "fractionCompleted")
        }
        request.endAccessingResources()
    }
    
    var request: NSBundleResourceRequest!
    var progressObserver: GameDownloadProgress?
}
