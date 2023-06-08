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
    @State var progress: Double = 0
    @State var sheet: Sheet?
    @State var token: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Habanero games work for Germany country")
            TextField("Token", text: $token)
            Button("SGRainbowmania") {
                openGame(
                    identifier: "habanero:SGRainbowmania"
                )
            }
            Button("SGDragonTigerGate") {
                openGame(
                    identifier: "habanero:SGDragonTigerGate"
                )
            }
            Button("TheAmazingMoneyMachine1") {
                openGame(
                    identifier: "pragmaticexternal:TheAmazingMoneyMachine1"
                )
            }
            Button("BigBassBonanza") {
                openGame(
                    identifier: "pragmaticexternal:BigBassBonanza"
                )
            }
            if progress > 0 {
                ProgressView.init(value: progress)
                    .progressViewStyle(.linear)
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
        identifier: String
    ) {
        Task {
            defer {
                progress = 0
                GameDownloader.shared.stop()
            }
            do {
                let progress = GameDownloadProgress { value in
                    withAnimation { self.progress = value }
                }
                let session = GameSession(token: token)
                var gameSession = try await session.create(identifier: identifier)
                gameSession += "&devicepack=1"
                gameSession = gameSession.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
                let gameArchName = identifier.replacingOccurrences(of: ":", with: "__") + ".zip"
                let gameArchPath = try await GameDownloader.shared.donwload(
                    tag: identifier,
                    archName: gameArchName,
                    progressObserver: progress
                )
                let gamePath = try GameArchiver.shared.unzip(path: gameArchPath)
                DispatchQueue.main.async { [gameSession] in
                    let url = GameServer.shared.start(
                        directoryPath: gamePath,
                        indexFilename: "index.html",
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
