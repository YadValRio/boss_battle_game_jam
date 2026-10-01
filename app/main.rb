require 'app/game.rb'
require 'app/arena.rb'
require 'app/player.rb'
require 'app/boss.rb'
require 'app/projectiles.rb'
require 'app/combat.rb'
require 'app/ui.rb'


$game = Game.new


def tick args
  $game.args = args
  $game.tick
end