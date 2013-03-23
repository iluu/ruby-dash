$LOAD_PATH << File.expand_path('./lib')

require 'bundler/setup'
require 'gaminator'
require 'rubydash_game'

def show_logo
  logo_path = "/data/logo.asci"
  file = File.open(File.join(File.dirname(__FILE__), logo_path))
  file.each do |line|
    puts line
  end

  inp = prompt 'RubyDash > '
  case inp.chomp
    when 's'
      run_game
    when 'b'
      show_best_scores
    when 'e'
      exit
    else
      exit
    end
end

def prompt(*args)
  print(*args)
  gets
end

def run_game
  Gaminator::Runner.new(RubydashGame).run
end

def exit
  Kernel.exit
end


show_logo


