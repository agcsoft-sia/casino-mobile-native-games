#!/usr/bin/env ruby

require 'json'
require 'pathname'

# Utils

def games(provider, source_path)
    providerGames = []
    Dir.chdir(provider) {
        Dir.each_child(Dir.pwd) { |file|
            if File.file?(file) && File.extname(file) == ".zip" then
                gameFileName = File.basename(file, ".*")
                gameIdentifier = gameFileName
                gameIdentifier["__"] = ":"
                gamePath = Pathname.new(File.absolute_path(file)).relative_path_from(Pathname.new(source_path).parent)
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

source_folder_name = ARGV[0] || ""
source_path = File.absolute_path(source_folder_name)

if source_folder_name.empty? then
    puts "Error: First arg must contains source folder name"
    exit
elsif !Dir.exist?(source_path) then
    puts "Error: Source folder does not exists"
    exit
end

# Main

meta = {}
providersMeta = []
gamesMeta = {}

Dir.chdir(source_folder_name) {
    Dir.each_child(Dir.pwd) { |provider|
        if Dir.exist?(provider) then
            providerGames = games(provider, source_path)
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
