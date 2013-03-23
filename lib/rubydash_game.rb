require 'map'
#IDEA:
# RUBY DASH!
#       Look out for The PYTHONS

class RubydashGame

  MAP_LVL_MAPPING = {
      1 => '../data/lvl1.map',
      2 => '../data/lvl2.map',
      3 => '../data/lvl3.map',
      4 => '../data/lvl4.map'
  }

  #Requires width and height params
  def initialize(width, height)
    @ticks = 100
    @width = width
    @height = height
    @eaten_rubies = 0
    @points = 0
    @map = Map.new

    #game start
    load_map(MAP_LVL_MAPPING[2])
    reset_speed
  end

  def load_map(file)
    @map.load_map file
    @player = @map.types['Player'].first
    @rubies = @map.types['Ruby']
    @rubies ||= []
  end

  def reset_speed
    @speed = 0
  end

  #Array of objects that are displayed on the screen
  def objects
    [@player] + @map.objects
  end

  #Mapping between keyboard keys and game actions
  def input_map
    {
        ?w => :move_up,
        ?s => :move_down,
        ?a => :move_left,
        ?d => :move_right,
        ?A => :eat_left,
        ?D => :eat_right,
        ?q => :exit
    }
  end

  #Called for every loop cycle
  def tick
    update_tick_count
    if @ticks % 4 == 0
      update_monsters
    end
  end

  def update_monsters
    @map.move_monsters
  end

  def update_tick_count
    @ticks += 1
  end

  def wait?
    false
  end

  def sleep_time
    0.05
  end

  def exit_message
    'Game just finished! Bye!'
  end

  def textbox_content
    "Rubies: #{@eaten_rubies}/#{@rubies.size} " +
        "Points: #@points"
  end

  def move_right
    move 1, 0 if @player.y < @width - 1
  end

  def move_left
    move -1, 0 if @player.x > 0
  end

  def move_up
    move 0, -1 if @player.y > 0
  end

  def move_down
    move 0, 1 if @player.y < @height -1
  end

  def move(x, y)
    @map.move_player x, y
  end

  def exit
    Kernel.exit
  end
end