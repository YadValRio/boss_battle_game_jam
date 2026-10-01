class Game

  # ==========================================
  # SCORE / STAMINA
  # ==========================================

  def render_scores

    outputs.labels << {

      x: 30,
      y: 30.from_top,

      text:
        "curr score: #{boss.damage}",

      r: 255,
      g: 255,
      b: 255
    }


    outputs.labels << {

      x: 30,
      y: 50.from_top,

      text:
        "high score: #{state.high_score}",

      r: 255,
      g: 255,
      b: 255
    }


    outputs.labels << {

      x: 30,
      y: 70.from_top,

      text:
        "stamina: #{player.stamina.to_i}",

      r: 255,
      g: 255,
      b: 255
    }
  end


  # ==========================================
  # CONTROLS
  # ==========================================

  def render_instructions

    outputs.labels << {

      x: 30,
      y: 70,

      text: "Controls:",

      r: 255,
      g: 255,
      b: 255
    }


    outputs.labels << {

      x: 30,
      y: 50,

      text:
        "Keyboard: WASD/Arrow keys to move. J to attack. K to dash.",

      r: 255,
      g: 255,
      b: 255
    }


    outputs.labels << {

      x: 30,
      y: 30,

      text:
        "Controller: D-Pad to move. A/B button to attack. X/Y button to dash.",

      r: 255,
      g: 255,
      b: 255
    }
  end


  # ==========================================
  # GAME OVER
  # ==========================================

  def render_game_over

    return unless state.game_over


    outputs.labels << {

      x: 640,
      y: 360,

      text: "GAME OVER!!!",

      alignment_enum: 1,
      size_enum: 3
    }
  end


  # ==========================================
  # HEARTS
  # ==========================================

  def render_hearts

    margin = 20


    player.hp.times do |i|

      outputs.sprites << {

        x:
          args.grid.w -
          margin -
          (
            (player.hp - i) *
            (state.heart_size + 8)
          ),

        y:
          args.grid.h -
          margin -
          state.heart_size,


        w: state.heart_size,
        h: state.heart_size,


        path:
          'sprites/boss-battle/heart_32x32.png'
      }
    end
  end


  # ==========================================
  # DEBUG HITBOXES
  # ==========================================

  def render_debug

    outputs.borders <<
      player_sprite_stand


    outputs.borders <<
      player_hurt_box


    outputs.borders <<
      player_hit_box


    outputs.borders <<
      boss_hurt_box


    outputs.borders <<
      boss_hit_box
  end


  # ==========================================
  # DEBUG TEXT
  # ==========================================

  def render_test_outputs

    is_debugging = false


    return unless is_debugging


    outputs.labels << {

      x: 30,
      y: 90.from_top,

      text:
        "In dash cooldown: #{player.in_dash_cooldown}"
    }


    outputs.labels << {

      x: 30,
      y: 110.from_top,

      text:
        "Cooldown temp: #{state.cooldown_temp}"
    }


    outputs.labels << {

      x: 30,
      y: 130.from_top,

      text:
        "Distance between them: #{state.dist}",

      r: 255,
      g: 255,
      b: 255
    }
  end

end