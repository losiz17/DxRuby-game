require 'dxruby'
require 'chipmunk'

require_relative 'lib/cp_Rectangle'
require_relative 'lib/cp_Square'

Window.width = 640
Window.height = 480

block = Image.load('images/Rectangle.png')
block2 = Image.load('images/Square.png')
i = 1

space = CP::Space.new
space.gravity = CP::Vec2.new(0, 100)
speed = 1 / 60.0


objects = []

Window.loop do
  space.step(speed)

  x=Input.mouse_pos_x
  y=Input.mouse_pos_y

case 
when Input.key_push?(K_1)
   i = 1 
when Input.key_push?(K_2)
   i = 2  
end

 
  objects.each do |obj|
    obj.draw
  end

case i
when  1
    if Input.mouse_push?(M_LBUTTON)
    objects << CPStaticRectangle.new(x, y , 128, 16, space)
    end  
  Window.draw_alpha(x,y,block,128)
when 2
  if Input.mouse_push?(M_LBUTTON)
    objects << CPStaticSquare.new(x,y,64,64,space) 
  end  
  Window.draw_alpha(x,y,block2,128)
end


end
