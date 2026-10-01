class Game

  # ==========================================
  # BOSS
  # ==========================================

  def boss
    state.boss
  end


  # ==========================================
  # UPDATE BOSS
  # ==========================================

  def calc_boss

    boss.attack_cooldown -= 1


    update_boss_target


    move_boss


    damage_player_from_boss


    boss_shoot
  end


  # ==========================================
  # BOSS TARGET
  # ==========================================

  def update_boss_target

    return unless boss.attack_cooldown < 0


    boss.target_x = player.x - 100
    boss.target_y = player.y - 100


    boss.attack_cooldown =

      if boss.damage > 200
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


  # ==========================================
  # MOVE BOSS
  # ==========================================

  def move_boss

    dx = boss.target_x - boss.x
    dy = boss.target_y - boss.y


    boss.x += dx * 0.25 ** 2
    boss.y += dy * 0.25 ** 2
  end


  # ==========================================
  # BOSS DAMAGES PLAYER
  # ==========================================

  def damage_player_from_boss

    touching_player =
      boss_hit_box.intersect_rect?(
        player_hurt_box
      )


    can_damage =
      player.damaged_at.elapsed?(120)


    if touching_player &&
       can_damage &&
       !player.is_dashing

      player.damaged_at = Kernel.tick_count

      player.hp -= 1


      if player.hp < 0
        player.hp = 0
      end
    end
  end


  # ==========================================
  # BOSS HITBOX
  # ==========================================

  def boss_hit_box

    hitbox_w = boss.w
    hitbox_h = boss.h


    {
      x: boss.x +
         (boss.w - hitbox_w) / 2 +
         190,

      y: boss.y +
         (boss.h - hitbox_h) / 2 -
         10,

      w: hitbox_w - 80,
      h: hitbox_h - 40
    }
  end


  # ==========================================
  # BOSS HURTBOX
  # ==========================================

  def boss_hurt_box

    hurtbox_w = boss.w
    hurtbox_h = boss.h


    {
      x: boss.x +
         (boss.w - hurtbox_w) / 2 +
         190,

      y: boss.y +
         (boss.h - hurtbox_h) / 2 -
         10,

      w: hurtbox_w - 80,
      h: hurtbox_h - 40
    }
  end


  # ==========================================
  # BOSS ATTACK STATE
  # ==========================================

  def boss_attack_state

    if boss.target_x.round != boss.x.round ||
       boss.target_y.round != boss.y.round

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


  # ==========================================
  # BOSS SHOOTING
  # ==========================================

  def boss_shoot

    return unless boss_attack_state == :will_attack


    can_fire =
      Kernel.tick_count >=
      state.fireball_cooldown_start +
      state.fireball_cooldown


    if state.dist > 580 && can_fire

      state.fireball_cooldown_start =
        Kernel.tick_count


      fire_fireball
    end
  end


  # ==========================================
  # RENDER BOSS
  # ==========================================

  def render_boss

    outputs.sprites << boss_sprite


    if boss_attack_state == :annoyed
      outputs.sprites << boss_powerup
    end
  end


  # ==========================================
  # CHOOSE BOSS SPRITE
  # ==========================================

  def boss_sprite

    case boss_attack_state


    when :sleeping

      boss_sprite_idle


    when :aware

      boss_sprite_idle


    when :annoyed

      boss_sprite_idle


    when :will_attack

      boss_sprite_attack


    when :attacking

      boss_sprite_attack


    else

      {
        x: boss.x,
        y: boss.y,

        w: boss.w,
        h: boss.h,

        r: 255,
        g: 0,
        b: 0
      }
    end
  end


  # ==========================================
  # IDLE SPRITE
  # ==========================================

  def boss_sprite_idle

    frame_count = 6
    frame_speed = 8


    frame = 0.frame_index(
      count: frame_count,
      hold_for: frame_speed,
      repeat: true
    )


    {
      x: boss.x,
      y: boss.y,

      w: boss.w + 300,
      h: boss.h + 100,

      path:
        "sprites/enemies/bosses/boss_demon/individual-sprites/01_demon_idle/demon_idle_#{frame + 1}.png",

      flip_horizontally:
        player.x - 170 > boss.x
    }
  end


  # ==========================================
  # ATTACK SPRITE
  # ==========================================

  def boss_sprite_attack

    frame_count = 12
    frame_speed = 8


    frame = 0.frame_index(
      count: frame_count,
      hold_for: frame_speed,
      repeat: true
    )


    {
      x: boss.x,
      y: boss.y,

      w: boss.w + 300,
      h: boss.h + 100,

      path:
        "sprites/enemies/bosses/boss_demon/individual-sprites/03_demon_cleave/demon_cleave_#{frame + 1}.png",

      flip_horizontally:
        player.x > boss.x
    }
  end


  # ==========================================
  # POWER UP EFFECT
  # ==========================================

  def boss_powerup

    frame_count = 12
    frame_speed = 8


    frame = 0.frame_index(
      count: frame_count,
      hold_for: frame_speed,
      repeat: true
    )


    {
      x: boss.x,
      y: boss.y,

      w: 400,
      h: 400,

      path:
        "sprites/special_effects/fire-aura/frames/FireMage_skill3_frame#{frame + 1}.png",

      flip_horizontally:
        player.x > boss.x
    }
  end

end