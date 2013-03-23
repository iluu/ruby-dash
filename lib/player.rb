class Player < Struct.new(:x, :y)

  attr_accessor :points

  def initialize(x, y, p=0)
    super x, y
    @points = p
  end

  def char
    '@'
  end

  def move(x, y)
    self.x += x
    self.y += y
  end

  def color
    Curses::COLOR_YELLOW
  end

  def increase_points
    @points += 1
  end

end

class Monster < Struct.new(:x, :y)

  def initialize(x, y)
    super x, y
    @direction = :right
  end

  def char
    'S'
  end

  def move(x, y)
    self.x += x
    self.y += y
    @direction = Directions.get_direction_for_move x, y
  end

  def color
    Curses::COLOR_YELLOW
  end

  def get_preferable_direction
    @direction
  end
end

class Ruby < Struct.new(:x, :y)
  attr_accessor :is_falling

  def initialize(x, y)
    self.x = x
    self.y = y
    @is_falling = false
  end


  def char
    'R'
  end

  def color
    Curses::COLOR_RED
  end

  def fall
    self.y += 1
    @is_falling = true
  end
end

class Ball < Struct.new(:x, :y)
  attr_accessor :is_falling

  def initialize(x, y)
    self.x = x
    self.y = y
    @is_falling = false
  end

  def char
    'O'
  end

  def color
    Curses::COLOR_BLUE
  end

  def fall
    self.y += 1
    @is_falling = true
  end

  def move(x, y)
    self.x += x
    self.y += y
  end
end

class Exit < Struct.new(:x, :y)
  def char
    'E'
  end

  def color
    Curses::COLOR_GREEN
  end
end

class Ground < Struct.new(:x, :y)
  def char
    '+'
  end

  def color
    Curses::COLOR_MAGENTA
  end
end

class Wall < Struct.new(:x, :y)
  def char
    '#'
  end

  def color
    Curses::COLOR_WHITE
  end
end

class MapBorder < Struct.new(:x, :y)
  def char
    '#'
  end

  def color
    Curses::COLOR_WHITE
  end
end