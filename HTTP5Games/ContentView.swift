//
//  ContentView.swift
//  HTTP5Games
//
//  Created by Ramil on 27.03.23.
//

import SwiftUI

enum Sheet: Identifiable {
    case game(URL)
    
    var id: Int { return 1 }
}

struct ContentView: View {
    @State var inProgress = false
    @State var sheet: Sheet?
    @State var token: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Habanero games work for Germany country")
            TextField("Token", text: $token)
            Button("SGRainbowmania") {
                openGame(
                    gameTag: "habanero:SGRainbowmania",
                    gameArchName: "SGRainbowmania.zip",
                    sharedFolderTag: "habanero",
                    sharedFolderArchName: "HBShared.zip",
                    indexFilename: "SGRainbowmania.html"
                )
            }
            Button("SGDragonTigerGate") {
                openGame(
                    gameTag: "habanero:SGDragonTigerGate",
                    gameArchName: "SGDragonTigerGate.zip",
                    sharedFolderTag: "habanero",
                    sharedFolderArchName: "HBShared.zip",
                    indexFilename: "SGDragonTigerGate.html"
                )
            }
            if inProgress {
                ProgressView()
            }
        }
        .sheet(item: $sheet, content: {
            switch $0 {
            case .game(let url):
                WebContentView(viewModel: WebContentViewModel(url: url))
                    .onDisappear(perform: GameServer.shared.stop)
            }
        })
    }
    
    private func openGame(
        gameTag: String,
        gameArchName: String,
        sharedFolderTag: String,
        sharedFolderArchName: String,
        indexFilename: String
    ) {
        Task {
            defer { inProgress = false }
            do {
                inProgress = true
                let session = GameSession(token: token)
                var gameSession = try await session.create(identifier: gameTag)
                gameSession += "&devicepack=1"
                gameSession = gameSession.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
                let sharedArchPath = try await GameDownloader.shared.donwload(
                    tag: sharedFolderTag,
                    archName: sharedFolderArchName
                )
                let gameArchPath = try await GameDownloader.shared.donwload(
                    tag: gameTag,
                    archName: gameArchName
                )
                let gamePath = try GameArchiver.shared.unzip(path: gameArchPath)
                try GameArchiver.shared.unzip(path: sharedArchPath, destination: gamePath)
                DispatchQueue.main.async { [gameSession] in
                    let url = GameServer.shared.start(
                        directoryPath: gamePath,
                        indexFilename: indexFilename,
                        session: gameSession
                    )
                    debugPrint(url)
                    sheet = .game(url)
                }
            } catch {
                guard let error = error as? GameDownloaderError else {
                    fatalError(error.localizedDescription)
                }
                fatalError(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
