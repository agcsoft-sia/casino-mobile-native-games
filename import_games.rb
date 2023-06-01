#!/usr/bin/env ruby

require 'xcodeproj'
require 'json'
require 'pathname'

project = ARGV[0] || ""
games_folder_name = ARGV[1] || ""
providers_meta_file_name = ARGV[2] || ""
games_meta_file_name = ARGV[3] || ""

if project.empty? then
    puts "Error: First arg must contains Xcode project name"
    exit
elsif games_folder_name.empty? then
    puts "Error: Second arg must contains games folder name"
    exit
elsif providers_meta_file_name.empty? then
    puts "Error: Third arg must contains providers meta file name"
    exit
elsif games_folder_name.empty? then
    puts "Error: Fourth arg must contains games meta file name"
    exit
end

Dir.chdir(__dir__)

project_path = File.absolute_path(project)
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

games_dir_path = File.absolute_path(games_folder_name)
games_group = project.new_group(games_folder_name, games_dir_path)

Dir.chdir(games_folder_name) {
    providers_meta_file_path = File.absolute_path(providers_meta_file_name)
    games_meta_file_path = File.absolute_path(games_meta_file_name)
    if !File.file?(providers_meta_file_path) then
        puts "Error: Providers meta file " + providers_meta_file_name + " doesn't exists"
        exit
    elsif !File.file?(games_meta_file_path) then
        puts "Error: Games meta file " + games_meta_file_name + " doesn't exists"
        exit
    end
    
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
            path = game["path"]
            
            if !File.file?(path) then
                puts "Warning: " + path + " folder doesn't exists"
                next
            end
            
            path_in_provider_group = Pathname.new(File.absolute_path(path)).relative_path_from(provider_dir_path)
            game_ref = provider_group.new_reference(path_in_provider_group)
            target.add_on_demand_resources({ identifier => [game_ref] })
        }
    }
}

project.save

puts "Done"
