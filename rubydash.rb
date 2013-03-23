$LOAD_PATH << File.expand_path('./lib')

require 'bundler/setup'
require 'gaminator'
require 'rubydash_game'

Gaminator::Runner.new(RubydashGame).run