class Game

  # PLAYER

  def player
    state.player
  end


  # ==========================================
  # INPUT
  # ==========================================

  def input

    return if state.game_over


    stamina_regen_rate = 0.5
    stamina_loss_rate = 0.2


    player.is_moving = false


    # ------------------------------------------
    # ATTACK
    # ------------------------------------------

    handle_player_attack


    # ------------------------------------------
    # MOVEMENT
    # ------------------------------------------

    if !player_attacking?

      vector = inputs.directional_vector


      dash_mult = handle_dash


      stamina_debuff =
        if player.stamina > 0
          1
        else
          0.5
        end


      if vector

        move_player(
          vector,
          dash_mult,
          stamina_debuff
        )


        player.is_moving = true


        if player.stamina > 0
          player.stamina -= stamina_loss_rate
        end


        update_player_direction vector
      end
    end


    # ------------------------------------------
    # REGENERATE STAMINA
    # ------------------------------------------

    if !player.is_moving &&
       player.stamina < 100

      player.stamina += stamina_regen_rate
    end


    # Prevent stamina from going above 100.
    if player.stamina > 100
      player.stamina = 100
    end
  end


  # ==========================================
  # ATTACK INPUT
  # ==========================================

  def handle_player_attack

    if input_attack?

      player.stamina -= 2

      player.slash_at = Kernel.tick_count
    end
  end


  def input_attack?

    inputs.controller_one.key_down.a ||
    inputs.controller_one.key_down.b ||
    inputs.keyboard.key_down.j
  end


  # ==========================================
  # DASH
  # ==========================================

  def handle_dash

    dash_distance = 18


    if input_dash? &&
       !player.in_dash_cooldown

      player.is_dashing = true

      player.in_dash_cooldown = true

      dash_mult = dash_distance

    else

      player.is_dashing = false

      dash_mult = 1
    end


    # ------------------------------------------
    # DASH COOLDOWN
    # ------------------------------------------

    if player.in_dash_cooldown
      state.cooldown_temp -= 1
    end


    if state.cooldown_temp <= 0

      player.in_dash_cooldown = false

      state.cooldown_temp = player.dash_cooldown
    end


    dash_mult
  end


  def input_dash?

    inputs.controller_one.key_down.x ||
    inputs.controller_one.key_down.y ||
    inputs.keyboard.key_down.k
  end


  # ==========================================
  # MOVE PLAYER
  # ==========================================

  def move_player vector, dash_mult, stamina_debuff

    next_player_x =
      player.x +
      vector.x *
      player.speed *
      dash_mult *
      stamina_debuff


    next_player_y =
      player.y +
      vector.y *
      player.speed *
      dash_mult *
      stamina_debuff


    if player_x_inside_stage? next_player_x
      player.x = next_player_x
    end


    if player_y_inside_stage? next_player_y
      player.y = next_player_y
    end
  end


  # ==========================================
  # DIRECTION
  # ==========================================

  def update_player_direction vector

    if vector.x < 0

      player.dir_x = -1

    elsif vector.x > 0

      player.dir_x = 1
    end


    if vector.y < 0

      player.dir_y = -1

    elsif vector.y > 0

      player.dir_y = 1
    end
  end


  # ==========================================
  # PLAYER BOUNDS
  # ==========================================

  def player_x_inside_stage? player_x

    return false if player_x < 0

    return false if (
      player_x +
      player.tile_size
    ) > 1280


    true
  end


  def player_y_inside_stage? player_y

    return false if player_y < 0

    return false if (
      player_y +
      player.tile_size
    ) > 720


    true
  end


  # ==========================================
  # ATTACK STATUS
  # ==========================================

  def player_attacking?

    return false if !player.slash_at

    return false if player.slash_at.elapsed?(
      player.slash_frames
    )


    true
  end


  def player_slash_can_damage?

    return false if !player_attacking?


    damage_frame =
      player.slash_at +
      player.slash_frames.idiv(2)


    return false if damage_frame != Kernel.tick_count


    true
  end


  # ==========================================
  # PLAYER HITBOX
  # ==========================================

  def player_hit_box

    sword_w = 50
    sword_h = 20


    if player.dir_x > 0

      {
        x: player.x +
           player.tile_size / 2 +
           sword_w / 2,

        y: player.y +
           player.tile_size / 2 -
           sword_h / 2,

        w: sword_w,
        h: sword_h
      }

    else

      {
        x: player.x +
           player.tile_size / 2 -
           sword_w / 2 -
           sword_w,

        y: player.y +
           player.tile_size / 2 -
           sword_h / 2,

        w: sword_w,
        h: sword_h
      }
    end
  end


  # ==========================================
  # PLAYER HURTBOX
  # ==========================================

  def player_hurt_box

    {
      x: player.x + 25,
      y: player.y + 25,

      w: 10,
      h: 10
    }
  end


  # ==========================================
  # RENDER PLAYER
  # ==========================================

  def render_player

    # ------------------------------------------
    # TEXT ABOVE PLAYER
    # ------------------------------------------

    if state.game_over

      outputs.labels << {
        x: player.x + player.tile_size / 2,
        y: player.y + 85,

        text: "RIP",

        size_enum: 2,
        alignment_enum: 1
      }


    elsif !player.damaged_at.elapsed?(120)

      outputs.labels << {
        x: player.x + player.tile_size / 2,
        y: player.y + 85,

        text: "ouch!!",

        size_enum: 2,
        alignment_enum: 1
      }
    end


    # ------------------------------------------
    # PLAYER SPRITE
    # ------------------------------------------

    if state.game_over

      outputs.sprites << player_sprite_stand.merge(
        angle: -90,
        flip_horizontally: false
      )


    elsif player.slash_at

      outputs.sprites << player_sprite_slash


    elsif player.is_moving ||
          player.is_dashing

      outputs.sprites << player_sprite_run


    else

      outputs.sprites << player_sprite_stand
    end
  end


  # ==========================================
  # RUNNING SPRITE
  # ==========================================

  def player_sprite_run

    tile_index = 0.frame_index(
      count: 6,
      hold_for: 3,
      repeat: true
    )


    tile_index ||= 0


    {
      x: player.x,
      y: player.y,

      w: player.tile_size,
      h: player.tile_size,

      path: 'sprites/boss-battle/player-run-tile-sheet.png',

      tile_x: tile_index * player.tile_size,
      tile_y: 0,

      tile_w: player.tile_size,
      tile_h: player.tile_size,

      flip_horizontally: player.dir_x > 0
    }
  end


  # ==========================================
  # STANDING SPRITE
  # ==========================================

  def player_sprite_stand

    {
      x: player.x,
      y: player.y,

      w: player.tile_size,
      h: player.tile_size,

      path: 'sprites/boss-battle/player-stand.png',

      flip_horizontally: player.dir_x > 0
    }
  end


  # ==========================================
  # SLASH SPRITE
  # ==========================================

  def player_sprite_slash

    tile_index = player.slash_at.frame_index(
      count: 5,
      hold_for: player.slash_frames.idiv(5),
      repeat: false
    )


    tile_index ||= 0


    tile_offset = 41.25


    if player.dir_x > 0

      {
        x: player.x - tile_offset,
        y: player.y - tile_offset,

        w: 165,
        h: 165,

        path: 'sprites/boss-battle/player-slash-tile-sheet.png',

        tile_x: tile_index * 128,
        tile_y: 0,

        tile_w: 128,
        tile_h: 128,

        flip_horizontally: true
      }

    else

      {
        x: player.x -
           tile_offset -
           tile_offset / 2,

        y: player.y - tile_offset,

        w: 165,
        h: 165,

        path: 'sprites/boss-battle/player-slash-tile-sheet.png',

        tile_x: tile_index * 128,
        tile_y: 0,

        tile_w: 128,
        tile_h: 128,

        flip_horizontally: false
      }
    end
  end

end