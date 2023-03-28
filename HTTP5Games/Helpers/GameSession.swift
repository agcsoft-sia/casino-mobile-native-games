//
//  GameSession.swift
//  HTTP5Games
//
//  Created by Ramil on 28.03.23.
//

import Foundation

class GameSession {
    init(token: String) {
        self.token = token
    }
    
    func create(identifier: String) async throws -> String {
        let url: URL! = URL(string: "https://platform.20bet.com/api/casino/create-game-session")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try jsonEncoder.encode(GameSessionBody(data: .init(
            gameIdentifier: identifier
        )))
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try jsonDecoder.decode(Response.self, from: data)
        return response.data.launchOptions.gameUrl
    }
    
    private let token: String
    private lazy var jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

private struct GameSessionBody: Encodable {
    let data: Data
    
    struct Data: Encodable {
        let gameIdentifier: String
        let mobile = true
    }
}

private struct Response: Decodable {
    let data: Data
    
    struct Data: Decodable {
        let launchOptions: LaunchOptions
    }
    
    struct LaunchOptions: Decodable {
        let gameUrl: String
    }
}
