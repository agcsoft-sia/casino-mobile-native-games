#!/usr/bin/env ruby

require 'json'

root = __dir__
Dir.chdir(root)

meta = {}

# Foreach providers folders
Dir.each_child(Dir.pwd) { |provider|
    if Dir.exist?(provider) then
        Dir.chdir(provider)
        # Foreach games files
        providerGames = []
        Dir.each_child(Dir.pwd) { |file|
            if File.file?(file) && File.extname(file) == ".zip" then
                gameFileName = File.basename(file, ".*")
                gameMeta = {
                    "id" => provider + ":" + gameFileName,
                    "name" => gameFileName
                }
                providerGames.push(gameMeta)
            end
        }
        meta[provider] = {
            "name": provider,
            "games": providerGames
        }
        Dir.chdir("..")
    end
}

Dir.chdir(root)
metaFile = File.new("meta.json", "w")
metaFile.write(meta.to_json)
metaFile.close

puts "meta.json is generated"
