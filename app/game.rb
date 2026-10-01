class Game

  FPS = 60

  attr_dr


  # MAIN GAME LOOP

  def tick
    defaults
    input
    calc
    render
  end


  # DEFAULTS

  def defaults
    state.high_score ||= 0
    state.damage_render_queue ||= []

    game_reset if Kernel.tick_count == 0 || state.start_new_game
  end


  # RESET GAME

  def game_reset
    state.start_new_game = false

    state.game_over = false
    state.game_over_countdown = nil


    # PLAYER

    state.player.is_dashing = false

    state.player.dash_cooldown = 0.85 * FPS
    state.player.in_dash_cooldown = false

    state.player.stamina = 100

    state.player.stamina_cooldown = 1.5 * FPS
    state.player.in_stamina_cooldown = false

    state.cooldown_temp = state.player.dash_cooldown


    state.player.tile_size = 64
    state.player.speed = 4

    state.player.slash_frames = 15

    state.player.hp = 3

    state.player.damaged_at = -1000

    state.player.x = 50
    state.player.y = 400

    state.player.dir_x = 1
    state.player.dir_y = -1

    state.player.is_moving = false

    state.player.slash_at = nil


    # BOSS

    state.boss.damage = 0

    state.boss.x = 800
    state.boss.y = 400

    state.boss.w = 256
    state.boss.h = 256

    state.boss.target_x = 800
    state.boss.target_y = 400

    state.boss.attack_cooldown = 600


    # FIREBALLS

    state.fireballs = []

    state.fireball_size = 256

    state.fireball_cooldown = 200

    state.fireball_cooldown_start = -1


    # HEARTS

    state.hearts = []

    state.heart_size = 64


    # DISTANCE BETWEEN PLAYER AND BOSS

    state.dist = 0
  end


  # CALCULATIONS

  def calc

    # Calculate this first because the boss
    # uses state.dist when deciding to shoot.
    calc_distance

    calc_player
    calc_boss

    calc_fireball

    calc_damage_render_queue
    calc_high_score
    calc_game_over
  end


  def calc_distance
    x_distance = boss.x - player.x
    y_distance = boss.y - player.y

    state.dist = Math.sqrt(
      x_distance ** 2 +
      y_distance ** 2
    )
  end


  def calc_damage_render_queue
    state.damage_render_queue.each do |label|
      label.a -= 5
    end

    state.damage_render_queue.reject! do |label|
      label.a < 0
    end
  end


  def calc_high_score
    if boss.damage > state.high_score
      state.high_score = boss.damage
    end
  end


  def calc_game_over

    if player.hp <= 0
      state.game_over = true
      state.game_over_countdown ||= 160
    end


    if state.game_over_countdown
      state.game_over_countdown -= 1
    end


    if state.game_over_countdown &&
       state.game_over_countdown < 0

      state.start_new_game = true
    end
  end


  # RENDER EVERYTHING

  def render

    # Arena
    draw_ground args
    draw_walls args
    draw_objects args


    # Characters
    render_boss
    render_player


    # Combat / objects
    render_fireballs
    render_damage_queue


    # UI
    render_scores
    render_instructions
    render_game_over
    render_hearts

    render_test_outputs

    # Uncomment when you want hitboxes:
    # render_debug
  end

end