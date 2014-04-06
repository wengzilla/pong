class Ball
  SIDE = 5

  attr_accessor :angle, :speed, :x, :y

  def initialize
    @x = Pong::WIDTH / 2
    @y = Pong::HEIGHT / 2
    @angle = (rand(90) + 45) + (rand(2) - 1) * 180
    @speed = 3
  end

  def dx
    Gosu.offset_x(angle, speed)
  end
  
  def dy
    Gosu.offset_y(angle, speed)
  end

  def draw(window)
    color = Gosu::Color::RED

    window.draw_quad(
      x2, y2, color,
      x2, y1, color,
      x1, y2, color,
      x1, y1, color
    )
  end

  def move!
    @x += dx
    @y += dy

    if @y < 0 || @y > Pong::HEIGHT
      @angle = Gosu.angle(0, 0, dx, -dy)
    end
  end

  def off_left?
    @x < 0
  end

  def off_right?
    @x > Pong::WIDTH
  end

  def intersect?(paddle)
    x1 < paddle.x2 && x2 > paddle.x1 && y1 < paddle.y2 && y2 > paddle.y1
  end

  def x1
    @x - SIDE
  end

  def x2
    @x + SIDE
  end

  def y1
    @y - SIDE
  end

  def y2
    @y + SIDE
  end

  def bounce_off_paddle!(paddle)
    if paddle.side == :left
      @x = paddle.x2 + SIDE
    elsif paddle.side == :right
      @x = paddle.x1 - SIDE
    end

    ratio = (@y - paddle.y) / Paddle::SIDE

    @angle = ratio * 120 + 90
    @angle = -1 * angle if paddle.side == :right

    @speed *= 1.05
  end
end