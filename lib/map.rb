$LOAD_PATH << File.expand_path('.')

require 'player'
require 'util'

class Map < Hash
  attr_accessor :objects, :types, :is_finished

  OBJECT_MAPPING = {
      'g' => Ground,
      'x' => MapBorder,
      'w' => Wall,
      'r' => Ruby,
      'b' => Ball,
      'p' => Player,
      'e' => Exit,
      's' => Monster
  }

  def initialize
    @objects = []
    @types = {}
    @is_finished = false
  end

  def load_map(file)
    file = File.open(File.join(File.dirname(__FILE__), file))
    y = 0
    file.each do |line|
      x = 0
      line.chomp.each_char do |char|
        create_object(char, x, y)
        x += 1
      end
      y += 1
    end
  end

  def create_object(char, x, y)
    if (obj = OBJECT_MAPPING[char])
      instance = obj.new(x, y)
      @objects.push instance
      self.set(x, y, instance)

      name = obj.name.split('::').last
      @types[name] ||= []
      @types[name].push(instance)
    end
  end

  def get(x, y)
    self[x][y] if self[x]
  end

  def set(x, y, value)
    self[x] = {} unless self[x]
    self[x][y] = value
  end

  def remove_object(object)
    return if object == nil

    x, y = object.x, object.y
    remove_from_objects object
    remove_from_map x, y
    remove_from_types object
  end

  def move_player(x, y)
    player = get_player
    new_x, new_y = player.x + x, player.y + y
    object_on_the_way = get(new_x, new_y)

    if can_move_player_to? object_on_the_way
      remove_object object_on_the_way
      remove_from_map player.x, player.y
      player.move x, y

      if object_on_the_way.is_a? Ruby
        player.increase_points
      elsif object_on_the_way.is_a? Exit
        @is_finished = true
      end
    end
  end

  def move_monsters
    get_monsters.each do |m|

      x_move, y_move = Directions.get_move_for_direction(m.get_preferable_direction)
      if get(m.x + x_move, m.y + y_move) == nil
        move_monster_to(x_move, y_move, m)
        return
      end

      x_move, y_move = Directions.get_random_move
      if get(m.x + x_move, m.y + y_move) == nil
        move_monster_to(x_move, y_move, m)
        return
      end

    end
  end

  def update_gravity
    get_gravity_aware_obj.each do |obj|
      if obj.is_falling && is_player_below(obj)
        return true
      end

      obj_below = get(obj.x, obj.y+1)
      if obj_below == nil && !is_player_below(obj)
        fall_down(obj)
      else
        obj.is_falling = false
      end
    end

    false
  end

  private

  def is_player_below(obj)
    get_player.x == obj.x && get_player.y == (obj.y + 1)
  end

  def remove_from_objects(object)
    @objects.delete(object)
  end

  def remove_from_map(x, y)
    set(x, y, nil)
  end

  def replace_on_map(old_x, old_y, object)
    set(old_x, old_y, nil)
    set(object.x, object.y, object)
  end

  def remove_from_types(object)
    name = object.class.name.split('::').last
    @types[name].delete(object)
  end

  def can_move_player_to?(object_on_the_way)
    object_on_the_way == nil or object_on_the_way.is_a?(Ruby) or object_on_the_way.is_a?(Ground) or object_on_the_way.is_a? Exit
  end

  def get_monsters
    @types['Monster'] ? @types['Monster'] : []
  end

  def get_gravity_aware_obj
    ball_array = @types['Ball'] ? @types['Ball'] : []
    ruby_array = @types['Ruby'] ? @types['Ruby'] : []

    ball_array + ruby_array
  end

  def get_player
    @types['Player'].first
  end

  def move_monster_to(x, y, monster)
    remove_from_map(monster.x, monster.y)
    monster.move(x, y)
  end

  def fall_down(object)
    old_x, old_y = object.x, object.y
    object.fall
    replace_on_map(old_x, old_y, object)
  end
end