module Clear
  class Director
    def initialize
      @image = Image.load('images/clear.png')
      @s = Sound.new("sounds/clear.wav")
    end

    def construction
      @s.play
    end

    def play
      Window.draw(0, 0, @image)
      Window.close if Input.key_push?(K_SPACE)
    end
  end
end