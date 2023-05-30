#!/usr/bin/env ruby
require 'xcodeproj'
project_path = './HTTP5Games.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

games_group = project.new_group('NativeGames', "./NativeGames")

provider_group = games_group.new_group('Habanero', "./Habanero")
game_ref = provider_group.new_reference('./HBShared.zip')
target.add_on_demand_resources({ "habanero": [game_ref] })
game_ref = provider_group.new_reference('./SGDragonTigerGate.zip')
target.add_on_demand_resources({ "habanero:SGDragonTigerGate" => [game_ref] })
game_ref = provider_group.new_reference('./SGRainbowmania.zip')
target.add_on_demand_resources({ "habanero:SGRainbowmania" => [game_ref] })

project.save
