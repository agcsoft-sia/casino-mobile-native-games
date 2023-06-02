#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'csv'
require 'zip'
require 'zip/filesystem'

# Utils

def search_identifier(gamesTable, filename)
    gamesTable.each { |row|
        if row[3] == filename then
            identifier = row[2]
            identifier[":"] = "__"
            return identifier
        end
    }
    return ""
end

def normilize_file_structure(zip_file_path, game_identifier)
    Zip::File.open(zip_file_path) { |zip_file|
        root_folder_name = "#{zip_file.dir.glob("*").first}"
        root_html_name = "#{root_folder_name}"
        root_html_name["/"] = ".html"
        new_root_folder_name = "#{game_identifier}/"
        
        # Rename all files
        zip_file.each { |entry|
            entry_new_name = "#{entry.name}"
            if entry_new_name.include?(root_folder_name) then
                entry_new_name[root_folder_name] = new_root_folder_name
                zip_file.rename(entry, entry_new_name)
            else
                puts "Warning: Something is worng with #{entry} during normalized process"
            end
        }
        # Rename index file
        zip_file.rename("#{root_folder_name}#{root_html_name}", "#{new_root_folder_name}index.html")
    }
end

# Main

sourceFolderName = ARGV[0] || ""
gamesTableFileName = ARGV[1] || ""
destinationFolderName = ARGV[2] || ""

if sourceFolderName.empty? then
    puts "Error: First arg must contains source folder name"
    exit
elsif gamesTableFileName.empty? then
    puts "Error: Second arg must contains games table CSV file name"
    exit
elsif destinationFolderName.empty? then
    puts "Error: Third arg must contains destination folder name"
    exit
elsif !Dir.exist?(sourceFolderName) then
    puts "Error: Source folder does not exists"
    exit
elsif !File.exist?(gamesTableFileName) then
    puts "Error: Games table CSV does not exists"
    exit
end

if !Dir.exist?(destinationFolderName) then
    Dir.mkdir(destinationFolderName)
    puts "Destination folder is created"
end
destinationDirPath = File.absolute_path(destinationFolderName)
gamesTable = CSV.read(File.absolute_path(gamesTableFileName))

Dir.chdir(sourceFolderName) {
    Dir.each_child(Dir.pwd) { |file|
        if File.file?(file) && File.extname(file) == ".zip" then
            gameFileName = File.basename(file, ".*")
            game_identifier = search_identifier(gamesTable, gameFileName)
            if game_identifier == "" then
                puts "Warning: File " + file + " doesn't exists in games table"
                next
            end
            normalizedGameFileName = "#{game_identifier}.zip"
            normalizedCopyPath = Pathname.new(destinationDirPath) + normalizedGameFileName
            
            FileUtils.cp(file, normalizedCopyPath)
            normilize_file_structure(normalizedCopyPath, game_identifier)
            
            puts "File " + file + " copied to " + destinationFolderName + "/" + normalizedGameFileName + " and normalized"
        end
    }
}

puts "Done"
