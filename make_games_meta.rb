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
                gameIdentifier = gameFileName
                gameIdentifier["__"] = ":"
                gamePath = Pathname.new(File.absolute_path(file)).relative_path_from(__dir__)
                gameMeta = {
                    "identifier" => gameIdentifier,
                    "path" => gamePath,
                }
                providerGames.push(gameMeta)
            end
        }
    }
    return providerGames
end

# Main

sourceFolderName = ARGV[0] || ""

if sourceFolderName.empty? then
    puts "Error: First arg must contains source folder name"
    exit
elsif !Dir.exist?(sourceFolderName) then
    puts "Error: Source folder does not exists"
    exit
end

meta = {}
providersMeta = []
gamesMeta = {}

Dir.chdir(sourceFolderName) {
    Dir.each_child(Dir.pwd) { |provider|
        if Dir.exist?(provider) then
            providerGames = games(provider)
            if !providerGames.empty? then
                providerMeta = {
                    "name": provider
                }
                providersMeta.push(providerMeta)
                gamesMeta[provider] = providerGames
            end
        end
    }
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