class Game

  # ==========================================
  # CREATE FIREBALL
  # ==========================================

  def fire_fireball

    # Center of player.
    target_x =
      player.x +
      player.tile_size / 2

    target_y =
      player.y +
      player.tile_size / 2


    # Center of boss.
    origin_x =
      boss.x +
      boss.w / 2

    origin_y =
      boss.y +
      boss.h / 2


    # Direction toward player.
    angle = Math.atan2(
      target_y - origin_y,
      target_x - origin_x
    )


    speed = 24


    sprite_angle =
      angle.to_degrees


    state.fireballs << {

      x:
        origin_x -
        state.fireball_size / 2,

      y:
        origin_y -
        state.fireball_size / 2,


      w: state.fireball_size,
      h: state.fireball_size,


      dx:
        Math.cos(angle) *
        speed,

      dy:
        Math.sin(angle) *
        speed,


      angle: sprite_angle,


      path:
        'sprites/boss-battle/fireball.png'
    }
  end


  # ==========================================
  # UPDATE FIREBALLS
  # ==========================================

  def calc_fireball

    state.fireballs.each do |fireball|

      move_fireball fireball

      damage_player_from_fireball fireball
    end


    remove_offscreen_fireballs
  end


  # ==========================================
  # MOVE FIREBALL
  # ==========================================

  def move_fireball fireball

    fireball.x += fireball.dx
    fireball.y += fireball.dy
  end


  # ==========================================
  # FIREBALL DAMAGE
  # ==========================================

  def damage_player_from_fireball fireball

    hitbox_size =
      state.fireball_size * 0.75


    fireball_hitbox = {

      x: fireball.x,
      y: fireball.y,

      w: hitbox_size,
      h: hitbox_size
    }


    hit_player =
      fireball_hitbox.intersect_rect?(
        player_hurt_box
      )


    can_damage =
      player.damaged_at.elapsed?(120)


    if hit_player &&
       can_damage &&
       !player.is_dashing

      player.damaged_at =
        Kernel.tick_count


      player.hp -= 1


      if player.hp < 0
        player.hp = 0
      end
    end
  end


  # ==========================================
  # DELETE OFF-SCREEN FIREBALLS
  # ==========================================

  def remove_offscreen_fireballs

    state.fireballs.reject! do |fireball|

      fireball.x < -state.fireball_size ||

      fireball.x > 1280 ||

      fireball.y < -state.fireball_size ||

      fireball.y > 720
    end
  end


  # ==========================================
  # RENDER FIREBALLS
  # ==========================================

  def render_fireballs
    outputs.sprites << state.fireballs
  end

end