module Gameover
  class Director
    def initialize
      @image = Image.load('images/gameover.png')
      @s = Sound.new("sounds/gameover.wav")
    end

    def construction
      @s.play
    end


    def play
      Window.draw(0, 0, @image)
      Scene.set_current_scene(:opening) if Input.key_push?(K_SPACE)
    end
  end
end