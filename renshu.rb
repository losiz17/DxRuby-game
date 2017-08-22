require 'dxruby'
require 'chipmunk'

require_relative 'director'
require_relative 'lib/base/cp_base'
require_relative 'lib/base/cp_box'
require_relative 'lib/base/cp_circle'
require_relative 'lib/base/cp_static_box'

require_relative 'lib/wall'
require_relative 'lib/ball'

Window.width = 640
Window.height = 480

director = Director.new
tmp = 0

Window.loop do
  break if Input.key_push?(K_ESCAPE)
  director.plays
  #p director.ball.body.v.y
 
  if (director.ball.body.v.y.to_i>1000 || director.ball.body.v.x.to_i> 1800) &&  tmp==0 

  	p 'gameover'
  	tmp = tmp + 1
  end
end








