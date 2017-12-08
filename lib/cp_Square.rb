class CPSquare < CPBox
  DEFAULT_COLLISION_TYPE = 200
  attr_reader :x,:y,:w,:h
  ########
  attr_accessor :ori_x,:ori_y
  ########

   def initialize(x, y, w, h,opt = {})
     super

    @x, @y = x, y
     ##########
         @ori_x = body.p.x
         @ori_y = body.p.y
     #########3


    @shape.collision_type = DEFAULT_COLLISION_TYPE
    @shape.e = 0.8
    @shape.u = 0.0
    #@shape.add_to_space(space)
    @body.moment = CP::INFINITY
    @body.mass = 1000000
  end

  def draw
    @body.v = CP::Vec2.new(0,0)
    super
  end
end