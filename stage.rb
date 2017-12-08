require 'dxruby'
require 'chipmunk'

#require_relative 'director'
require_relative 'lib/base/cp_base'
require_relative 'lib/base/cp_box'
require_relative 'lib/base/cp_circle'
require_relative 'lib/base/cp_static_box'

require_relative 'lib/cp_Rectangle'
require_relative 'lib/cp_Square'

require_relative 'lib/wall'
require_relative 'lib/ball'

require_relative 'scene'
require_relative 'scenes/opening/director'
require_relative 'scenes/clear/director'
require_relative 'scenes/gameover/director'

require_relative 'scenes/stage1/director'
require_relative 'scenes/stage2/director'
require_relative 'scenes/stage3/director'

Window.width = 1024
Window.height = 768

Scene.add_scene(Opening::Director.new,  :opening)
Scene.add_scene(Clear::Director.new,  :clear)
Scene.add_scene(Gameover::Director.new,  :gameover)

Scene.add_scene(Stage1::Director.new,  :stage1)
Scene.add_scene(Stage2::Director.new,  :stage2)
Scene.add_scene(Stage3::Director.new,  :stage3)

Scene.set_current_scene(:opening)

Window.loop do

  break if Input.key_push?(K_ESCAPE)
  Scene.play_scene

end
