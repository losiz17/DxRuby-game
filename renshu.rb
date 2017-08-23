require 'dxruby'
require 'chipmunk'

require_relative 'director'
require_relative 'lib/base/cp_base'
require_relative 'lib/base/cp_box'
require_relative 'lib/base/cp_circle'
require_relative 'lib/base/cp_static_box'

require_relative 'lib/wall'
require_relative 'lib/ball'

Window.width = 1024
Window.height = 768

font=Font.new(16)

director = Director.new
tmp = 0

goal=Image.load('images/goal.png')

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

end
