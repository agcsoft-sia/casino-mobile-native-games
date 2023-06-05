#!/usr/bin/env ruby

require 'xcodeproj'
require 'json'
require 'pathname'

project = ARGV[0] || ""
games_folder_name = ARGV[1] || ""
providers_meta_file_name = ARGV[2] || ""
games_meta_file_name = ARGV[3] || ""

games_dir_path = File.absolute_path(games_folder_name)
providers_meta_file_path = File.absolute_path(providers_meta_file_name)
games_meta_file_path = File.absolute_path(games_meta_file_name)

if project.empty? then
    puts "Error: First arg must contains Xcode project name"
    exit
elsif games_folder_name.empty? then
    puts "Error: Second arg must contains games folder name"
    exit
elsif providers_meta_file_name.empty? then
    puts "Error: Third arg must contains providers meta file name"
    exit
elsif games_meta_file_name.empty? then
    puts "Error: Fourth arg must contains games meta file name"
    exit
elsif !Dir.exist?(games_dir_path) then
    puts "Error: Games folder does not exists"
    exit
elsif !File.file?(providers_meta_file_path) then
    puts "Error: Providers meta file " + providers_meta_file_name + " doesn't exists"
    exit
elsif !File.file?(games_meta_file_path) then
    puts "Error: Games meta file " + games_meta_file_name + " doesn't exists"
    exit
end

project_path = File.absolute_path(project)
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

games_group = project.new_group(games_folder_name, games_dir_path)

Dir.chdir(games_folder_name) {
    providers_meta_file = File.open(providers_meta_file_path).read
    providers_meta = JSON.parse(providers_meta_file)
    games_meta_file = File.open(games_meta_file_path).read
    games_meta = JSON.parse(games_meta_file)
    
    providers_meta.each { |provider|
        provider_name = provider["name"]
        provider_games = games_meta[provider_name]
        
        provider_dir_path = File.absolute_path(provider_name)
        if !Dir.exist?(provider_dir_path) then
            puts "Warning: " + provider_name + " provider's folder doesn't exists"
            next
        end
        provider_group = games_group.new_group(provider_name, provider_dir_path)
        
        provider_games.each { |game|
            identifier = game["identifier"]
            game_path = game["path"]
            game_path = Pathname.new(games_dir_path).parent + Pathname.new(game_path)
            game_path_in_provider_dir = game_path.relative_path_from(Pathname.new(provider_dir_path))
            
            if !File.file?(game_path) then
                puts "Warning: " + File.absolute_path(game_path) + " file doesn't exists"
                next
            end
            
            game_ref = provider_group.new_reference(game_path_in_provider_dir)
            target.add_on_demand_resources({ identifier => [game_ref] })
        }
    }
}

project.save

puts "Done"
