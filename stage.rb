require 'dxruby'
require 'chipmunk'

require_relative 'director'
require_relative 'lib/base/cp_base'
require_relative 'lib/base/cp_box'
require_relative 'lib/base/cp_circle'
require_relative 'lib/base/cp_static_box'

require_relative 'lib/cp_Rectangle'
require_relative 'lib/cp_Square'

require_relative 'lib/wall'
require_relative 'lib/ball'

Window.width = 1024
Window.height = 768

block = Image.load('images/Rectangle.png')
block2 = Image.load('images/Square.png')
i = 1

font=Font.new(16)

director = Director.new
tmp = 0

goal=Image.load('images/goal.png')

space = CP::Space.new
space.gravity = CP::Vec2.new(0, 100)
speed = 1 / 60.0


Window.loop do
  break if Input.key_push?(K_ESCAPE)
  director.plays
  #p director.ball.body.p.y
  #Window.draw_font(0,0,"y=#{director.ball.body.p.y.to_i}",font)

  if director.ball.body.p.y.to_i>800 &&  tmp==0 

    p 'gameover1'
    Window.draw_font(100, 100, "gameover1", font)
    tmp = tmp + 1
    #break
  end

  if director.ball.body.p.x.to_i> 1800 &&  tmp==0
    p 'gameover2'
    tmp = tmp + 1
  end

  if  director.ball.body.p.y.to_i> 672 && director.ball.body.p.y.to_i<768 && director.ball.body.p.x.to_i> 976 && director.ball.body.p.x.to_i<1024  &&tmp == 0
    p 'clear'
    Window.draw_font(100, 100, "clear", font)
    tmp = tmp + 1
    #break
  end

  Window.draw(976,672,goal)

  x=Input.mouse_pos_x
  y=Input.mouse_pos_y

case 
when Input.key_push?(K_1)
   i = 1 
when Input.key_push?(K_2)
   i = 2  
end


case i
when  1
    if Input.mouse_push?(M_LBUTTON)
    unless x>=0&&x<=100&&y>=0&&y<=100 
    director.add_obj(CPStaticRectangle.new(x, y , 128, 16, space))
    end
    end  
  Window.draw_alpha(x,y,block,128)
when 2
  if Input.mouse_push?(M_LBUTTON)
  unless x>=0&&x<=100&&y>=0&&y<=100 
   director.add_obj(CPStaticSquare.new(x,y,64,64,space))
  end
  end  
  Window.draw_alpha(x,y,block2,128)
end


end
