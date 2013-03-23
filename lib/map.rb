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

      name = obj.name.split('::').last
      @types[name] ||= []
      @types[name].push(instance)
    end
  end
end
