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
    @current_map_number = 1

    reset_vars
  end

  def reset_vars
    @original_map_rubies_number = 0
    @map = Map.new
    @player_killed = false

    #game start
    load_map(MAP_LVL_MAPPING[@current_map_number])
    reset_speed
  end

  def load_map(file)
    @map = Map.new
    @map.load_map file
    p = @player ? @player.points : 0
    @player = @map.types['Player'].first
    @player.points = p
    @rubies = @map.types['Ruby']
    @rubies ||= []
    @original_map_rubies_number = @rubies.length
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
    if @player_killed
      keymap = {
          ?x => :reload,
          ?q => :exit
      }
    else
      keymap =
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
    keymap
  end

  def reload

  end

  #Called for every loop cycle
  def tick
    unless @player_killed
      update_tick_count

      @player_killed = update_gravity

      if @ticks % 4 == 0
        @player_killed = update_monsters
      end
    end
  end

  def update_gravity
    @map.update_gravity
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
    txt = "Rubies: #{@original_map_rubies_number - @rubies.size}/#{@original_map_rubies_number} " +
        "Points: #{@player.points}"

    if @player_killed
       txt += "\tYou were killed! Press 'x' to try again!"
    end

    txt
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

    if @map.is_finished
      @current_map_number += 1
      reset_vars
    end
  end

  def exit
    Kernel.exit
  end
end