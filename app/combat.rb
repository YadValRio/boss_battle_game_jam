class Game

  # PLAYER COMBAT

  def calc_player

    # Remove the attack once its animation
    # has finished.
    if !player_attacking?
      player.slash_at = nil
    end


    return unless player_slash_can_damage?


    if player_hit_box.intersect_rect?(
      boss_hurt_box
    )

      boss.damage += 1


      damage_text_x =
        player_hit_box.x +
        player_hit_box.w / 2 *
        player.dir_x


      damage_text_y =
        player_hit_box.y +
        player_hit_box.h / 2


      queue_damage(
        damage_text_x,
        damage_text_y
      )
    end
  end


  # DAMAGE TEXT

  def queue_damage x, y

    rand_x_offset = rand * 20
    rand_y_offset = rand * 20


    if rand < 0.5
      rand_x_offset *= -1
    end


    if rand < 0.5
      rand_y_offset *= -1
    end


    state.damage_render_queue << {

      x: x + rand_x_offset,
      y: y + rand_y_offset,

      a: 255,

      text: "wack!"
    }
  end


  # DRAW DAMAGE TEXT

  def render_damage_queue
    outputs.labels << state.damage_render_queue
  end

end