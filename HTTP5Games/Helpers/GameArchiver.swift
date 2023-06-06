//
//  GameArchiver.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import Foundation
import Zip

enum GameArchiverError: Error {
    case invalidPath
}

class GameArchiver {
    static let shared = GameArchiver()
    
    private init() {}
    
    @discardableResult
    func unzip(path: URL, destination: URL? = nil) throws -> URL {
        if let destination {
            try Zip.unzipFile(
                path,
                destination: destination,
                overwrite: true,
                password: nil
            )
            return destination
        } else {
            var urlPath = try Zip.quickUnzipFile(path) 
            let folderName = path.lastPathComponent.replacingOccurrences(of: ".\(path.pathExtension)", with: "")
            urlPath.appendPathComponent(folderName)
            return urlPath
        }
    }
}
