class Paddle
  SIDE = 80
  THICKNESS = 10
  VELOCITY = 5

  attr_accessor :side, :x, :y

  def initialize(side)
    @side = side
    @x = left? ? THICKNESS / 2 : Pong::WIDTH - THICKNESS / 2
    @y = Pong::HEIGHT / 2
  end

  def left?
    side == :left
  end

  def draw(window)
    color = Gosu::Color::GREEN

    if left?
      window.draw_quad(
        x2, y2, color,
        x2, y1, color,
        x1, y2, color,
        x1, y1, color
      )
    else
      window.draw_quad(
        x1, y2, color,
        x1, y1, color,
        x2, y2, color,
        x2, y1, color
      )
    end
  end

  def x1
    @x - THICKNESS / 2
  end

  def x2
    @x + THICKNESS / 2
  end

  def y1
    @y - SIDE / 2
  end

  def y2
    @y + SIDE / 2
  end

  def up!
    @y -= VELOCITY
  end

  def down!
    @y += VELOCITY
  end
end