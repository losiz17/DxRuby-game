class Ball < CPCircle
  DEFAULT_COLLISION_TYPE = 3
  DEFAULT_E = 1.0
  DEFAULT_U = 1.0
  CONTROL_SCALE_FACTOR = 3  # コントロール矢印がボールに与える加速度の補助係数

  def initialize(x, y, r, opt = {})
    super

    # ボールの物理特性を設定
    self.shape.e = opt[:shape_e] || DEFAULT_E  # 弾性係数（0.0 - 1.0）
    self.shape.u = opt[:shape_u] || DEFAULT_U  # 摩擦係数（0.0 - 1.0）
    self.shape.collision_type = opt[:collision_type] || DEFAULT_COLLISION_TYPE  # 衝突種別

    # コントロール用矢印画像読み込み
    @arrow = Image.load('images/arrow.png')

    @image=Image.load('images/korochan.png')
    @image.set_color_key([255,255,255])

    # フラグ初期化
    @dragging = false  # ボールをドラッグ中にtrue化
    @dropped = false   # ボールをドロップした際にtrue化

  end

  # 描画メソッドオーバーライド
  # ボール画像描画後、operationメソッドを実行
  # ※ 1フレーム単位で本メソッドが処理されていることに留意
  def draw
    super
    operation
  end

  private

  # ボールのコントロール用ベースメソッド
  # コントロール矢印は、以下の3つの状態を取る点に留意
  # * 何も操作されていない状態
  # * ドラッグ中
  # * ドラッグ後にドロップされる
  def operation
    if dragging?
      drag
    else
      drop if @dropped
    end
  end

  # ドラッグ中かどうかの判定
  def dragging?
    if Input.mouse_down?(M_LBUTTON)
      r_x = ((@body.p.x - @r)..(@body.p.x + @r)).include?(Input.mouse_x) # マウスクリック可能なボールのX成分範囲
      r_y = ((@body.p.y - @r)..(@body.p.y + @r)).include?(Input.mouse_y) # マウスクリック可能なボールのY成分範囲
      # クリック地点がボール画像の範囲内であれば、ドラッグ中と判定
      if r_x && r_y
        @dragging = true && @body.p.x >= 0 && @body.p.x <= 100 && @body.p.y >= 0 && @body.p.y <= 100
      end
    else
      @dropped = true if @dragging  # ドロップ状態をtrueにするには、そのフレームがドラッグ中であることが必須
      @dragging = false
    end
    @dragging
  end

  # コントロール矢印をドラッグした際の1フレーム単位の処理内容
  def drag
    # ボールの現在位置と、マウス座標を確保し、それぞれコントロール矢印の始点・終点座標として用いる
    x, y, x2, y2 = @body.p.x, @body.p.y, Input.mouse_x, Input.mouse_y

    # 始点・終点座標から、コントロール矢印の角度を求める
    @rad = Math.atan2(y2 - y,x2 - x)              # 一旦、逆正接を取ってラジアン角を得て…
    deg = ( @rad * 180.0 / Math::PI )                 # DxRubyでの描画のため、度単位に変換
    @dst = Math.sqrt((x2 - x) ** 2 + (y2 - y) ** 2)/6 # 三平方の定理により、コントロール矢印の大きさを得る
    opt = {
      angle: deg,
      center_x: 0,
      center_y: @arrow.height / 2,
      scale_x: @dst / @arrow.width.to_f
    }
    Window.draw_ex(@body.p.x, @body.p.y - @arrow.height / 2, @arrow, opt)  # ここまでで得られた値から、矢印を描画
  end

  # ドロップ時の処理内容
  # 当該時点の矢印の大きさ（@dst）をベクトル成分に分解し、@bodyの加速度
  # として与える。
  # ※ その際、一定倍率を掛けて加速度の変化量をコントロールする。
  def drop
    dx = @dst * Math.cos(@rad)
    dy = @dst * Math.sin(@rad)
    @body.v = (vec2(dx, dy) * CONTROL_SCALE_FACTOR)
    @dropped = false
  end
end
