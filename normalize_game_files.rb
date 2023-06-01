#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'csv'

# Utils
def searchIdentifier(gamesTable, filename)
    gamesTable.each { |row|
        if row[3] == filename then
            identifier = row[2]
            identifier[":"] = "_"
            return identifier
        end
    }
    return ""
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

Dir.chdir(__dir__)

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
            normalizedGameFileName = searchIdentifier(gamesTable, gameFileName)
            if normalizedGameFileName == "" then
                puts "Warning: File " + file + " doesn't exists in games table"
                next
            end
            normalizedGameFileName = normalizedGameFileName + ".zip"
            normalizedCopyPath = Pathname.new(destinationDirPath) + normalizedGameFileName
            FileUtils.cp(file, normalizedCopyPath)
            puts "File " + file + " copied to " + destinationFolderName + "/" + normalizedGameFileName
        end
    }
}


puts "Done"
