module Stage2
  class Director
    def initialize

      @block = Image.load('images/Rectangle.png')
      @block2 = Image.load('images/Square.png')
      @block.set_color_key([255,255,255])
      @block2.set_color_key([255,255,255])

      @goal=Image.load('images/goal.png')
      @goal.set_color_key([255,255,255])
      @start=Image.load('images/start.png')
      @start.set_color_key([255,255,255])
      @tate=Image.load('images/tate.png')
      @tate.set_color_key([0,0,0])

      @koro=Image.load('images/korochan.png')
@koro.set_color_key([255,255,255])
@kakeru=Image.load('images/multiply.png')
@number=[]
@number[0]=Image.load('images/number_0.png')
@number[1]=Image.load('images/number_1.png')
@number[2]=Image.load('images/number_2.png')
@number[3]=Image.load('images/number_3.png')
@number[4]=Image.load('images/number_4.png')
@number[5]=Image.load('images/number_5.png')
@number[6]=Image.load('images/number_6.png')
@number[7]=Image.load('images/number_7.png')
@number[8]=Image.load('images/number_8.png')
@number[9]=Image.load('images/number_9.png')

      @font=Font.new(16)

      @objects = {}

      @bgm=Sound.new("sounds/bgm.wav")
      @bgm.loop_count=-1

    end

    def construction

      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 200)
      @speed = 1 / 60.0

      @objects = {}
      @i=1
      [
        [0, 100, 100, 50,@start],
        [Window.width/2-50, Window.height/4-50 , 50, 100,@tate],
        [Window.width/2-50, Window.height/4+50 , 50, 100,@tate],
        [Window.width/2-50, Window.height/4+150, 50, 100,@tate],
        [Window.width/2-50, Window.height/4+250, 50, 100,@tate]

      ].each do |x, y, w, h,image|
        add_obj(Wall.new(x, y, w, h,image))
      end

      @ball = Ball.new(10, 50, 15)
      add_obj(@ball)

@background=Image.load('images/stage2.png')


      @block_num=0
      @bgm.play

##########################################################衝突　判定
      @space.add_collision_handler(CPRectangle::DEFAULT_COLLISION_TYPE, CPRectangle::DEFAULT_COLLISION_TYPE) do |box1, box2, arb|
        @space.add_post_step_callback(box1) do |_, shape|
          case @i
          when 1
            remove_obj(box1)
            ########
            @objects[box2].body.p.x = @objects[box2].ori_x
            @objects[box2].body.p.y = @objects[box2].ori_y
            ########
            @block_num-=1
          else
            remove_obj(box2)
            ########
            @objects[box1].body.p.x = @objects[box1].ori_x
            @objects[box1].body.p.y = @objects[box1].ori_y
            ########
            @block_num-=1
          end
        end
      end

      @space.add_collision_handler(CPSquare::DEFAULT_COLLISION_TYPE, CPSquare::DEFAULT_COLLISION_TYPE) do |box1, box2, arb|
        @space.add_post_step_callback(box1) do |_, shape|
          case @i
          when 1
            remove_obj(box2)
            ########
            @objects[box1].body.p.x = @objects[box1].ori_x
            @objects[box1].body.p.y = @objects[box1].ori_y
            ########
            @block_num-=1
          else
            remove_obj(box1)
            ########
            @objects[box2].body.p.x = @objects[box2].ori_x
            @objects[box2].body.p.y = @objects[box2].ori_y
            ########
            @block_num-=1
          end
        end
      end

      @space.add_collision_handler(CPRectangle::DEFAULT_COLLISION_TYPE, CPSquare::DEFAULT_COLLISION_TYPE) do |box1, box2, arb|
        @space.add_post_step_callback(box1) do |_, shape|
          case @i
          when 1
            remove_obj(box1)
            ########
            @objects[box2].body.p.x = @objects[box2].ori_x
            @objects[box2].body.p.y = @objects[box2].ori_y
            ########
            @block_num-=1
          else
            remove_obj(box2)
            ########
            @objects[box1].body.p.x = @objects[box1].ori_x
            @objects[box1].body.p.y = @objects[box1].ori_y
            ########
            @block_num-=1
          end
        end
      end

       @space.add_collision_handler(Wall::DEFAULT_COLLISION_TYPE, CPRectangle::DEFAULT_COLLISION_TYPE) do |box1, box2, arb|
        @space.add_post_step_callback(box1) do |_, shape|

            remove_obj(box2)
            @block_num-=1
        end
      end

       @space.add_collision_handler(Wall::DEFAULT_COLLISION_TYPE, CPSquare::DEFAULT_COLLISION_TYPE) do |box1, box2, arb|
        @space.add_post_step_callback(box1) do |_, shape|

            remove_obj(box2)
            @block_num-=1

        end
      end

##################################################################################

    end

    def play

      Window.draw(0,0,@background)

      @objects.values.each {|obj| obj.draw }

      Window.draw(900,20,@koro)
            Window.draw_scale(940,25,@kakeru,0.15,0.15,0,0)
            Window.draw_scale(970,13,@number[$life],0.35,0.35,0,0)

            if @i==1
              Window.draw_scale(865,73,@block,0.5,0.5,0,0)
            elsif @i==2
              Window.draw_scale(900,65,@block2,0.5,0.5,0,0)
            end
            Window.draw_scale(940,70,@kakeru,0.15,0.15,0,0)
            Window.draw_scale(970,60,@number[9-@block_num],0.35,0.35,0,0)

      @space.step(@speed)

      Window.draw(976,672,@goal)





      x=Input.mouse_pos_x
      y=Input.mouse_pos_y


###########################################ゲーム画面の変遷

      if @ball.body.p.y.to_i>800 ||@ball.body.p.x.to_i > 1100 || @ball.body.p.x.to_i < -100

              $life-=1
        @bgm.stop
              Scene.set_current_scene(:stage2)

              if $life==0
                @bgm.stop
                Scene.set_current_scene(:gameover)

              end

            end

            if  @ball.body.p.y.to_i> 672 && @ball.body.p.y.to_i<768 && @ball.body.p.x.to_i> 976 && @ball.body.p.x.to_i<1024
              @bgm.stop
              Scene.set_current_scene(:stage3)

            end


      if Input.key_push?(K_SPACE)
        @bgm.stop
              Scene.set_current_scene(:stage2)
            end

####################################################ブロックの切り替え
      case
      when Input.key_push?(K_1)
         @i = 1
      when Input.key_push?(K_2)
         @i = 2
      end

case @i
      when  1

        if @block_num<9
          if Input.mouse_push?(M_LBUTTON)
          unless x>=0&&x<=100&&y>=0&&y<=100
          add_obj(CPRectangle.new(x, y , 128, 32, {image: 'images/Rectangle.png'}))
            @block_num+=1
          end
          end
      end
        Window.draw_alpha(x,y,@block,128)
      when 2
if @block_num<9
        if Input.mouse_push?(M_LBUTTON)
        unless x>=0&&x<=100&&y>=0&&y<=100
         add_obj(CPSquare.new(x,y,64,64,{image: 'images/Square.png'}))
          @block_num+=1
        end
        end
end
        Window.draw_alpha(x,y,@block2,128)
      end

    end

  end

########################################################
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


