class Directions

  def self.get_move_for_direction(direction)

    if direction == :left
      return [-1, 0]
    elsif direction == :right
      return [1, 0]
    elsif direction == :up
      return [0, 1]
    elsif direction == :down
      return [0, -1]
    end
  end

  def self.get_direction_for_move(x, y)

    if x == -1 and y == 0
      return :left
    elsif x == 1 and y == 0
      return :right
    elsif x == 0 and y = 1
      return :up
    elsif x == 0 and y == -1
      return :down
    end
  end

  def self.get_random_move

    rand_num = Random.rand(4)

    if rand_num == 0
      return get_move_for_direction :left
    elsif rand_num == 1
      return get_move_for_direction :right
    elsif rand_num == 2
      return get_move_for_direction :up
    else
      return get_move_for_direction :down
    end
  end
end