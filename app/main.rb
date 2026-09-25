class Game
  FPS = 60
  attr_dr
def draw_walls args
  size = 100
  wall_size = 20
  x = 50
  y = 0

  while x < args.grid.w - 40
    args.outputs.sprites << {
      x: x,
      y: -4.5,
      w: wall_size,
      h: wall_size,
      path: 'sprites/tile/steampunk/steampunk_rust_side_2.png',
      flip_vertically: true,
    }
    args.outputs.sprites << {
      x: x,
      y: 700,
      w: wall_size,
      h: wall_size,
      path: 'sprites/tile/steampunk/steampunk_rust_side_2.png',
    }
    x += wall_size
  end
while y < args.grid.h - 80
  args.outputs.sprites << {
    x: 0,
    y: y + 40,
    w: wall_size, 
    h: wall_size,
    path: 'sprites/tile/steampunk/steampunk_rust_side_2_vertical.png',
    flip_horizontally: true
  }
  args.outputs.sprites << {
    x: 1260,
    y: y + 40,
    w: wall_size, 
    h: wall_size,
    path: 'sprites/tile/steampunk/steampunk_rust_side_2_vertical.png',
  }
  y += 10
end
  args.outputs.sprites << {
    x: 0,
    y: 620,
    w: size,
    h: size,
    path: 'sprites/tile/steampunk/steampunk_corner_rust.png' 
  }
  args.outputs.sprites << {
    x: 1180,
    y: 620,
    w: size,
    h: size,
    path: 'sprites/tile/steampunk/steampunk_corner_rust.png',
    flip_horizontally: true
  }
  args.outputs.sprites << {
    x: 0,
    y: 0,
    w: size,
    h: size,
    path: 'sprites/tile/steampunk/steampunk_corner_rust.png' ,
    flip_vertically: true
  }
  args.outputs.sprites << {
    x: 1180,
    y: 0,
    w: size,
    h: size,
    path: 'sprites/tile/steampunk/steampunk_corner_rust.png',
    flip_horizontally: true,
    flip_vertically: true
  }
end

 
def draw_ground args
  size = 64 #size of the ground tiles
  x = 0 #where the first tile begins

  while x < args.grid.w   
    args.outputs.sprites << {
      x: x,
      y: 700,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 640,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 580,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 520,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 460,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 400,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 340,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 280,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 220,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }
    args.outputs.sprites << {
      x: x,
      y: 160,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }

    args.outputs.sprites << {
      x: x,
      y: 100,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
     
    }

    args.outputs.sprites << {
      x: x,
      y: 40,
      w: size,
      h: size,   
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }

    args.outputs.sprites << {
      x: x,
      y: -20,
      w: size,
      h: size,
      path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
    }

    x += size
  end
  
end
def draw_objects args
  object_size = 64
  x = 0

  # Torch animation settings
  frame_count = 4
  frame_speed = 6

  # Calculate the current animation frame
  frame = 0.frame_index(
    count: frame_count,
    hold_for: frame_speed,
    repeat: true
  )

  while x < args.grid.w
    args.outputs.sprites << {
      x: x + 100,
      y: 30,
      w: object_size,
      h: object_size,

      path: 'sprites/objects/lights/torch-animated.png',

      tile_x: frame * object_size,
      tile_y: 0,
      tile_w: object_size,
      tile_h: object_size
  }
    args.outputs.sprites << {
      x: x + 100,
      y: 625,
      w: object_size,
      h: object_size,

      path: 'sprites/objects/lights/torch-animated.png',

      tile_x: frame * object_size,
      tile_y: 0,
      tile_w: object_size,
      tile_h: object_size
  }
  x += 150
end
end



  def tick
    defaults
    input
    calc
    render
  end
  


  def defaults
    state.high_score          ||= 0
    state.damage_render_queue ||= []
    game_reset if Kernel.tick_count == 0 || state.start_new_game
  end

  def game_reset
    state.start_new_game      = false
    state.game_over           = false
    state.game_over_countdown = nil

    # added variables
    state.player.is_dashing         = false
    state.player.dash_cooldown      = 1 * FPS # in seconds
    state.player.in_dash_cooldown   = false
    state.player.stamina            = 100
    state.player.stamina_cooldown   = 1.5 * FPS # in seconds
    state.player.in_stamina_cooldown= false

    state.cooldown_temp = player.dash_cooldown

    state.player.tile_size          = 64
    state.player.speed              = 4
    state.player.slash_frames       = 15
    state.player.hp                 = 3
    state.player.damaged_at         = -1000
    state.player.x                  = 50
    state.player.y                  = 400
    state.player.dir_x              =  1
    state.player.dir_y              = -1
    state.player.is_moving          = false

    state.boss.damage               = 0
    state.boss.x                    = 800
    state.boss.y                    = 400
    state.boss.w                    = 256
    state.boss.h                    = 256
    state.boss.target_x             = 800
    state.boss.target_y             = 400
    state.boss.attack_cooldown      = 600

    state.dist = Math.sqrt((boss.y - player.y) ** 2 + (boss.x - player.x) ** 2)
    
  end

  def input
    stamina_regen_rate = 0.5
    stamina_loss_rate = 0.2
    return if state.game_over

    player.is_moving = false

    if input_attack?
      player.stamina -= 2
      player.slash_at = Kernel.tick_count
    end

    if !player_attacking?
      vector = inputs.directional_vector
      dash_distance = 18
      if input_dash? && !player.in_dash_cooldown
        puts "It's really dashing time" 
        dash_mult = dash_distance
        player.in_dash_cooldown = true
      else 
        dash_mult = 1
      end

      if dash_mult == 1
        player.is_dashing = false
      elsif dash_mult == dash_distance
        player.is_dashing = true
      else
        puts "Something is off with player.is_dashing"
      end

      if player.in_dash_cooldown
        #puts "Cooldown should be decreasing #{state.cooldown_temp}"
        state.cooldown_temp -= 1
      end

      if state.cooldown_temp <= 0
        player.in_dash_cooldown = false
        state.cooldown_temp = player.dash_cooldown
      end

      if player.stamina > 0
        stamina_debuff = 1
      else
        stamina_debuff = 0.5
      end

      if vector
        next_player_x = player.x + vector.x * player.speed * dash_mult * stamina_debuff
        next_player_y = player.y + vector.y * player.speed * dash_mult * stamina_debuff
        player.x = next_player_x if player_x_inside_stage? next_player_x
        player.y = next_player_y if player_y_inside_stage? next_player_y

        player.is_moving = true

        if player.stamina > 0
          player.stamina -= stamina_loss_rate
        end

        player.dir_x = if vector.x < 0
                         -1
                       elsif vector.x > 0
                         1
                       else
                         player.dir_x
                       end

        player.dir_y = if vector.y < 0
                         -1
                       elsif vector.y > 0
                         1
                       else
                         player.dir_y
                       end
      end
    end

    if !player.is_moving && player.stamina < 100
      player.stamina += stamina_regen_rate
    end
  end

  def input_attack?
    inputs.controller_one.key_down.a ||
    inputs.controller_one.key_down.b ||
    inputs.keyboard.key_down.j
  end

  def input_dash?
    inputs.controller_one.key_down.x ||
    inputs.controller_one.key_down.y ||
    inputs.keyboard.key_down.k
  end

  def calc
    calc_player
    calc_boss
    calc_damage_render_queue
    calc_high_score
    calc_game_over
  end

  def calc_player
    player.slash_at = nil if !player_attacking?
    return unless player_slash_can_damage?
    if player_hit_box.intersect_rect? boss_hurt_box
      boss.damage += 1
      queue_damage player_hit_box.x + player_hit_box.w / 2 * player.dir_x,
                   player_hit_box.y + player_hit_box.h / 2
    end
  end

  def calc_boss
    boss.attack_cooldown -= 1
    if boss.attack_cooldown < 0
      boss.target_x = player.x - 100
      boss.target_y = player.y - 100
      boss.attack_cooldown = if    boss.damage > 200
                               200
                             elsif boss.damage > 150
                               300
                             elsif boss.damage > 100
                               400
                             elsif boss.damage > 50
                               500
                             else
                               600
                             end
    end

    dx = boss.target_x - boss.x
    dy = boss.target_y - boss.y
    boss.x += dx * 0.25 ** 2
    boss.y += dy * 0.25 ** 2

    if boss.intersect_rect?(player_hurt_box) && player.damaged_at.elapsed?(120) && !player.is_dashing
      player.damaged_at = Kernel.tick_count
      player.hp -= 1
      player.hp  = 0 if player.hp < 0
    end

    boss_shoot
  end

  def calc_damage_render_queue
    state.damage_render_queue.each { |label| label.a -= 5 }
    state.damage_render_queue.reject! { |l| l.a < 0 }
  end

  def calc_high_score
    state.high_score = boss.damage if boss.damage > state.high_score
  end

  def calc_game_over
    if player.hp <= 0
      state.game_over = true
      state.game_over_countdown ||= 160
    end

    state.game_over_countdown -= 1 if state.game_over_countdown
    state.start_new_game = true    if state.game_over_countdown && state.game_over_countdown < 0
  end

  def render
    draw_ground args
    draw_walls args
    draw_objects args
    render_boss
    render_player
    render_damage_queue
    render_scores
    render_instructions
    render_game_over
    # render_debug
    render_test_outputs

  end

  def render_player
    outputs.labels << { x: player.x + 5,
                        y: player.y + 5,
                        text: "hp: #{player.hp}", r:255, g:255, b:255 }

    if state.game_over
      outputs.labels << { x: player.x + player.tile_size / 2,
                          y: player.y + 85,
                          text: "RIP",
                          size_enum: 2,
                          alignment_enum: 1 }
    elsif !player.damaged_at.elapsed?(120)
      outputs.labels << { x: player.x + player.tile_size / 2,
                          y: player.y + 85,
                          text: "ouch!!",
                          size_enum: 2,
                          alignment_enum: 1 }
    end

    if state.game_over
      outputs.sprites << player_sprite_stand.merge(angle: -90, flip_horizontally: false)
    elsif player.slash_at
      outputs.sprites << player_sprite_slash
    elsif player.is_moving || player.dash
      outputs.sprites << player_sprite_run
    else
      outputs.sprites << player_sprite_stand
    end
  end

  def render_boss
    outputs.sprites << boss_sprite
  end

  def render_damage_queue
    outputs.labels << state.damage_render_queue
  end

  def render_scores
    outputs.labels << { x: 30, y: 30.from_top, text: "curr score: #{boss.damage}", r:255, g: 255, b:255}
    outputs.labels << { x: 30, y: 50.from_top, text: "high score: #{state.high_score}", r:255, g: 255, b:255}
    outputs.labels << { x: 30, y: 70.from_top, text: "stamina: #{player.stamina.to_i}", r:255, g: 255, b:255}
  end

  def render_instructions
    outputs.labels << { x: 30, y: 70, text: "Controls:", r:255, g:255, b:255}
    outputs.labels << { x: 30, y: 50, text: "Keyboard:   WASD/Arrow keys to move. J to attack. K to dash." , r:255, g:255, b:255}
    outputs.labels << { x: 30, y: 30, text: "Controller: D-Pad to move. A/B button to attack. X/Y button to dash." , r:255, g:255, b:255}
  end

  def render_game_over
    return unless state.game_over
    outputs.labels << { x: 640, y: 360, text: "GAME OVER!!!", alignment_enum: 1, size_enum: 3 }
  end

  def render_debug
    outputs.borders << player_sprite_stand
    outputs.borders << player_hurt_box
    outputs.borders << player_hit_box
    outputs.borders << boss_hurt_box
    outputs.borders << boss_hit_box
  end

  def player
    state.player
  end

  def player_x_inside_stage? player_x
    return false if player_x < 0
    return false if (player_x + player.tile_size) > 1280
    return true
  end

  def player_y_inside_stage? player_y
    return false if player_y < 0
    return false if (player_y + player.tile_size) > 720
    return true
  end

  def player_attacking?
    return false if !player.slash_at
    return false if player.slash_at.elapsed?(player.slash_frames)
    return true
  end

  def player_slash_can_damage?
    return false if !player_attacking?
    return false if (player.slash_at + player.slash_frames.idiv(2)) != Kernel.tick_count
    return true
  end

  def player_hit_box
    sword_w = 50
    sword_h = 20
    if player.dir_x > 0
      {
        x: player.x + player.tile_size / 2 + sword_w / 2,
        y: player.y + player.tile_size / 2 - sword_h / 2,
        w: sword_w,
        h: sword_h
      }
    else
      {
        x: player.x + player.tile_size / 2 - sword_w / 2 - sword_w,
        y: player.y + player.tile_size / 2 - sword_h / 2,
        w: sword_w,
        h: sword_h
      }
    end
  end

  def player_hurt_box
    {
      x: player.x + 25,
      y: player.y + 25,
      w: 10,
      h: 10
    }
  end

  def player_sprite_run
    tile_index = 0.frame_index count:    6,
                               hold_for: 3,
                               repeat:   true

    tile_index = 0 if !player.is_moving && !player.dash # review this?

    {
      x:                 player.x,
      y:                 player.y,
      w:                 player.tile_size,
      h:                 player.tile_size,
      path:              'sprites/boss-battle/player-run-tile-sheet.png',
      tile_x:            0 + (tile_index * player.tile_size),
      tile_y:            0,
      tile_w:            player.tile_size,
      tile_h:            player.tile_size,
      flip_horizontally: player.dir_x > 0,
    }
  end

  def player_sprite_stand
    {
      x:                 player.x,
      y:                 player.y,
      w:                 player.tile_size,
      h:                 player.tile_size,
      path:              'sprites/boss-battle/player-stand.png',
      flip_horizontally: player.dir_x > 0,
    }
  end

  def player_sprite_slash
    tile_index   = player.slash_at.frame_index count: 5,
                                               hold_for: player.slash_frames.idiv(5),
                                               repeat: false

    tile_index ||= 0
    tile_offset = 41.25

    if player.dir_x > 0
      {
        x:                 player.x - tile_offset,
        y:                 player.y - tile_offset,
        w:                 165,
        h:                 165,
        path:              'sprites/boss-battle/player-slash-tile-sheet.png',
        tile_x:            0 + (tile_index * 128),
        tile_y:            0,
        tile_w:            128,
        tile_h:            128,
        flip_horizontally: true
      }
    else
      {
        x:                 player.x - tile_offset - tile_offset / 2,
        y:                 player.y - tile_offset,
        w:                 165,
        h:                 165,
        path:              'sprites/boss-battle/player-slash-tile-sheet.png',
        tile_x:            0 + (tile_index * 128),
        tile_y:            0,
        tile_w:            128,
        tile_h:            128,
        flip_horizontally: false
      }
    end
  end

  def boss
    state.boss
  end

  def boss_hurt_box
    {
      x: boss.x,
      y: boss.y,
      w: boss.w,
      h: boss.h
    }
  end

  def boss_hit_box
    {
      x: boss.x,
      y: boss.y,
      w: boss.w,
      h: boss.h
    }
  end

  def boss_sprite
    case boss_attack_state
    when :sleeping
      { x: boss.x,
        y: boss.y,
        w: boss.w,
        h: boss.h,
        path: 'sprites/boss-battle/boss-sleeping.png' }
    when :aware
      { x: boss.x,
        y: boss.y,
        w: boss.w,
        h: boss.h,
        path: 'sprites/boss-battle/boss-aware.png' }
    when :annoyed
      { x: boss.x,
        y: boss.y,
        w: boss.w,
        h: boss.h,
        path: 'sprites/boss-battle/boss-annoyed.png' }
    when :will_attack
      shake_x  =  2 * rand
      shake_x *= -1 if rand < 0.5

      shake_y  =  2 * rand
      shake_y *= -1 if rand < 0.5

      { x: boss.x + shake_x,
        y: boss.y + shake_x,
        w: boss.w,
        h: boss.h,
        path: 'sprites/boss-battle/boss-will-attack.png' }
    when :attacking
      flip_horizontally = false
      flip_horizontally = true if boss.target_x > boss.x

      { x: boss.x,
        y: boss.y,
        w: boss.w,
        h: boss.h,
        flip_horizontally: flip_horizontally,
        path: 'sprites/boss-battle/boss-attacking.png' }
    else
      { x: boss.x, y: boss.y, w: boss.w, h: boss.h, r: 255, g: 0, b: 0 }
    end
  end

  def boss_shoot
    case boss_attack_state
    when :will_attack
      if state.dist > 650
        puts "Boss is far, will shoot"
      else puts "I guess the boss is close?"
      end
    end
  end

  def boss_attack_state
    if boss.target_x.round != boss.x.round || boss.target_y.round != boss.y.round
      :attacking
    elsif boss.attack_cooldown < 30
      :will_attack
    elsif boss.attack_cooldown < 120
      :annoyed
    elsif boss.attack_cooldown < 180
      :aware
    else
      :sleeping
    end
  end

  def queue_damage x, y
    rand_x_offset = rand * 20
    rand_y_offset = rand * 20
    rand_x_offset *= -1 if rand < 0.5
    rand_y_offset *= -1 if rand < 0.5
    state.damage_render_queue << { x: x + rand_x_offset, y: y + rand_y_offset, a: 255, text: "wack!" }
  end
end

def render_test_outputs
  #outputs.labels << { x: 30, y: 90.from_top, text: "In dash cooldown: #{player.in_dash_cooldown}" }
  #outputs.labels << { x: 30, y: 110.from_top, text: "Cooldown temp: #{state.cooldown_temp}" }
  outputs.labels << { x: 30, y: 130.from_top, text: "Distance between them: #{state.dist}",r:255, g: 255, b:255 }
end

$game = Game.new

def tick args
  $game.args = args
  $game.tick
  state.dist = Math.sqrt((state.boss.y - state.player.y) ** 2 + (state.boss.x - state.player.x) ** 2)
end
DR.reset