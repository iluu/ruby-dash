require 'map'
#IDEA:
# RUBY DASH!
#       Look out for The PYTHONS

class RubydashGame

  MAP_LVL_MAPPING = {
      1 => '../data/lvl1.map',
      2 => '../data/lvl2.map'
  }

  #Requires width and height params
  def initialize(width, height)
    @width = width
    @height = height
    @map = Map.new

    #game start
    load_map(MAP_LVL_MAPPING[2])

  end

  def load_map(file)
    @map.load_map file
    puts @map.types.keys
    start = @map.types['Player'].first
    @player = Player.new(start.x, start.y)
  end

  #Array of objects that are displayed on the screen
  def objects
    @map.objects
  end

  #Mapping between keyboard keys and game actions
  def input_map
    {
        ?w => :move_up,
        ?s => :move_down,
        ?a => :move_left,
        ?d => :move_right,
        ?A => :eat_left,
        ?D => :eat_right
    }
  end

  #Called for every loop cycle
  def tick
  end

  def wait?
    true
  end

  def sleep_time
    0.05
  end

  def exit_message
    'Game just finished! Bye!'
  end

  def textbox_content
    'This is the text box content!'
  end

  def move_right
    move 1, 0 if @player.y < @width - 1
  end

  def move_left

  end

  def move_up

  end

  def move_down

  end

  def eat_left

  end

  def eat_right

  end



end