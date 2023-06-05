#!/usr/bin/env ruby

require 'zip'
require 'pathname'

source_folder_name = ARGV[0] || ""
destination_folder_name = ARGV[1] || ""

if source_folder_name.empty? then
    puts "Error: First arg must contains source folder name"
    exit
elsif destination_folder_name.empty? then
    puts "Error: Second arg must contains destination folder name"
    exit
elsif !Dir.exist?(source_folder_name) then
    puts "Error: Source folder does not exists"
    exit
end

if !Dir.exist?(destination_folder_name) then
    Dir.mkdir(destination_folder_name)
    puts "Destination folder is created"
end

destination_dir = File.absolute_path(destination_folder_name)

Dir.chdir(source_folder_name) {
    Dir.each_child(Dir.pwd) { |file|
        if Dir.exist?(file) then
            output_path = Pathname.new(destination_dir) + file
            Zip::File.open("#{output_path}.zip", Zip::File::CREATE) { |zipfile|
                Dir.glob("#{file}/**/**").each { |game_file|
                    zipfile.add(game_file, game_file)
                }
            }
            puts "#{output_path}.zip created"
        end
    }
}

puts "Done"
