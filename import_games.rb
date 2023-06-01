#!/usr/bin/env ruby

require 'xcodeproj'

project = ARGV[0] || ""
games_folder_name = ARGV[1] || ""

if project.empty? then
    puts "Error: First arg must contains Xcode project name"
    exit
elsif games_folder_name.empty? then
    puts "Error: Second arg must contains games folder name"
    exit
end

Dir.chdir(__dir__)

project_path = File.absolute_path(project)
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

games_dir_path = File.absolute_path(games_folder_name)
games_group = project.new_group(games_folder_name, games_dir_path)

Dir.chdir(games_folder_name) {
    Dir.each_child(Dir.pwd) { |provider|
        if Dir.exist?(provider) then
            Dir.chdir(provider) {
                provider_dir_path = Dir.pwd
                provider_group = games_group.new_group(provider, provider_dir_path)
                
                Dir.each_child(Dir.pwd) { |file|
                    if File.file?(file) && File.extname(file) == ".zip" then
                        gameIdentifier = File.basename(file, ".*")
                        gameIdentifier["_"] = ":"
                        game_file_path = File.absolute_path(file)
                        
                        game_ref = provider_group.new_reference(game_file_path)
                        target.add_on_demand_resources({ gameIdentifier => [game_ref] })
                    end
                }
            }
        end
    }
}

project.save

puts "Done"
