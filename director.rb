class Director
  WALL_WIDTH = 1
  BOX_SIZE = 100
  attr_accessor :ball
  def initialize
    @space = CP::Space.new
    @space.gravity = CP::Vec2.new(0,700)
    @speed = 1 / 60.0
    @objects = {}

    [
    
      [WALL_WIDTH, 100, 100, WALL_WIDTH],                                     # è·äQíIÇªÇÃÇP
    ].each do |x, y, w, h|
      add_obj(Wall.new(x, y, w, h))
    end

   

    @ball = Ball.new(10, 50, 15)
    add_obj(@ball)


  end

 
  def plays
   
    @space.step(@speed)

    
    @objects.values.each {|obj| obj.draw }
  end

 private

 
  def add_obj(obj)
    @objects[obj.shape] = obj
    obj.add_to(@space)
  end

  
  def remove_obj(shape)
    @objects[shape].remove_from(@space)
    @objects.delete(shape)
  end
end

