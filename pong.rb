require 'hasu'
Hasu.load "ball.rb"
Hasu.load "paddle.rb"

class Pong < Hasu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super(640, 480, false)
    @left_score = 0
    @right_score = 0
  end

  def reset
    @font = Gosu::Font.new(self, "Arial", 20)
    @ball = Ball.new
    @left_paddle = Paddle.new(:left)
    @right_paddle = Paddle.new(:right)
  end

  def update
    @ball.move!
  end

  def draw
    @font.draw("#{@left_score}", 30, 10, 1.0, 1.0, 1.0)
    @font.draw("#{@right_score}", WIDTH - 50, 10, 1.0, 1.0, 1.0)
    @ball.draw(self)

    @left_paddle.draw(self)
    @right_paddle.draw(self)

    if @ball.off_left?
      @left_score += 1
      @ball = Ball.new
    end

    if @ball.off_right?
      @right_score += 1
      @ball = Ball.new
    end

    if true
      if @left_paddle.y < @ball.y
        @left_paddle.down!
      end

      if @left_paddle.y > @ball.y
        @left_paddle.up!
      end
    else
      if button_down?(Gosu::KbW)
        @left_paddle.up!
      end

      if button_down?(Gosu::KbS)
        @left_paddle.down!
      end
    end
    
    if false
      if @right_paddle.y < @ball.y
        @right_paddle.down!
      end

      if @right_paddle.y > @ball.y
        @right_paddle.up!
      end
    else
      if button_down?(Gosu::KbUp)
        @right_paddle.up!
      end

      if button_down?(Gosu::KbDown)
        @right_paddle.down!
      end
    end

    if @ball.intersect?(@left_paddle)
      @ball.bounce_off_paddle!(@left_paddle)
    end

    if @ball.intersect?(@right_paddle)
      @ball.bounce_off_paddle!(@right_paddle)
    end
  end
end


Pong.run
