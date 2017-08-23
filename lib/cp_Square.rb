class CPStaticSquare
  attr_accessor :shape, :body
  def initialize(x, y, w, h, space)
    @x, @y = x, y
    @image = Image.load('images/Square.png')
    @body = CP::StaticBody.new
    @body.p = CP::Vec2.new(0, 0)
    verts = [
      CP::Vec2.new(x, y),         # 第１頂点（左上）
      CP::Vec2.new(x, y + h),     # 第２頂点（左下）
      CP::Vec2.new(x + w, y + h), # 第３頂点（右下）
      CP::Vec2.new(x + w, y)      # 第４頂点（右上）
    ]
    @shape = CP::Shape::Poly.new(@body, verts, CP::Vec2.new(0, 0))
    @shape.e = 0.5
    @shape.u = 0.0
    #@shape.add_to_space(space)
  end

  def draw
    Window.draw(@x, @y, @image)
  end

  def add_to(space)
    self.shape.add_to_space(space)
    self.body.add_to_space(space) unless self.body.class == CP::StaticBody # StaticBodyはspaceへ登録できないための条件づけ
  end
end