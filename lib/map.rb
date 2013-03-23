$LOAD_PATH << File.expand_path('.')

require 'player'

class Map < Hash
  attr_accessor :objects, :types

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

  private

  def remove_from_objects(object)
    @objects.delete(object)
  end

  def remove_from_map(x, y)
    set(x, y, nil)
  end

  def remove_from_types(object)
    name = object.class.name.split('::').last
    @types[name].delete(object)
  end
end
