#!/usr/bin/env ruby

require 'json'
require 'pathname'

# Utils

def games(provider)
    providerGames = []
    Dir.chdir(provider) {
        Dir.each_child(Dir.pwd) { |file|
            if File.file?(file) && File.extname(file) == ".zip" then
                gameFileName = File.basename(file, ".*")
                gamePath = Pathname.new(File.absolute_path(file)).relative_path_from(__dir__)
                gameMeta = {
                    "id" => provider + ":" + gameFileName,
                    "name" => gameFileName,
                    "path" => gamePath,
                }
                providerGames.push(gameMeta)
            end
        }
    }
    return providerGames
end

# Main

Dir.chdir(__dir__)

meta = {}
providersMeta = []
gamesMeta = {}

# Foreach providers folders
Dir.each_child(Dir.pwd) { |provider|
    if Dir.exist?(provider) then
        providerGames = games(provider)
        if !providerGames.empty? then
            providerMeta = {
                "id": provider
            }
            providersMeta.push(providerMeta)
            gamesMeta[provider] = providerGames
        end
    end
}

providersMetaFile = File.new("providers.json", "w")
providersMetaFile.write(providersMeta.to_json)
providersMetaFile.close
puts "providers.json is generated"

gamesMetaFile = File.new("games.json", "w")
gamesMetaFile.write(gamesMeta.to_json)
gamesMetaFile.close
puts "games.json is generated"

puts "Done"
