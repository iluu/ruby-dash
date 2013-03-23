class Player < Struct.new(:x, :y)
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

end

class Monster < Struct.new(:x, :y)
  def char
    'S'
  end

  def move(x, y)
    self.x += x
    self.y += y
  end

  def color
    Curses::COLOR_YELLOW
  end
end

class Ruby < Struct.new(:x, :y)
  def char
    'R'
  end

  def color
    Curses::COLOR_RED
  end
end

class Ball < Struct.new(:x, :y)
  def char
    'O'
  end

  def color
    Curses::COLOR_BLUE
  end
end

class Exit < Struct.new(:x, :y)
  def char
    'EE'
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