module Opening
  class Director
    def initialize
      @image = Image.load('images/opening.png')
    end

    def construction
      $life=5
    end

    def play
      Scene.set_current_scene(:stage1) if Input.key_push?(K_SPACE)
      Window.draw(0, 0, @image)
    end
  end
end