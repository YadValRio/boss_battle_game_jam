class Game

  # ==========================================
  # WALLS
  # ==========================================

  def draw_walls args

    size = 100
    wall_size = 20

    x = 50
    y = 0


    # ------------------------------------------
    # TOP AND BOTTOM WALLS
    # ------------------------------------------

    while x < args.grid.w - 40

      args.outputs.sprites << {
        x: x,
        y: -4.5,
        w: wall_size,
        h: wall_size,

        path: 'sprites/tile/steampunk/steampunk_rust_side_2.png',

        flip_vertically: true
      }


      args.outputs.sprites << {
        x: x,
        y: 700,
        w: wall_size,
        h: wall_size,

        path: 'sprites/tile/steampunk/steampunk_rust_side_2.png'
      }


      x += wall_size
    end


    # ------------------------------------------
    # LEFT AND RIGHT WALLS
    # ------------------------------------------

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

        path: 'sprites/tile/steampunk/steampunk_rust_side_2_vertical.png'
      }


      y += 10
    end


    # ------------------------------------------
    # TOP LEFT CORNER
    # ------------------------------------------

    args.outputs.sprites << {
      x: 0,
      y: 620,

      w: size,
      h: size,

      path: 'sprites/tile/steampunk/steampunk_corner_rust.png'
    }


    # ------------------------------------------
    # TOP RIGHT CORNER
    # ------------------------------------------

    args.outputs.sprites << {
      x: 1180,
      y: 620,

      w: size,
      h: size,

      path: 'sprites/tile/steampunk/steampunk_corner_rust.png',

      flip_horizontally: true
    }


    # ------------------------------------------
    # BOTTOM LEFT CORNER
    # ------------------------------------------

    args.outputs.sprites << {
      x: 0,
      y: 0,

      w: size,
      h: size,

      path: 'sprites/tile/steampunk/steampunk_corner_rust.png',

      flip_vertically: true
    }


    # ------------------------------------------
    # BOTTOM RIGHT CORNER
    # ------------------------------------------

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


  # ==========================================
  # GROUND
  # ==========================================

  def draw_ground args

    size = 64

    x = 0


    while x < args.grid.w

      y = -20


      while y <= 700

        args.outputs.sprites << {
          x: x,
          y: y,

          w: size,
          h: size,

          path: 'sprites/tile/steampunk/steampunk_panel_iron_bolt_vertborder.png'
        }


        y += 60
      end


      x += size
    end
  end


  # ==========================================
  # OBJECTS
  # ==========================================

  def draw_objects args

    object_size = 64

    x = 0


    frame_count = 4
    frame_speed = 6


    frame = 0.frame_index(
      count: frame_count,
      hold_for: frame_speed,
      repeat: true
    )


    while x < args.grid.w

      draw_torch(
        args,
        x + 100,
        30,
        object_size,
        frame
      )


      draw_torch(
        args,
        x + 100,
        625,
        object_size,
        frame
      )


      x += 150
    end
  end


  # ==========================================
  # TORCH
  # ==========================================

  def draw_torch args, x, y, size, frame

    args.outputs.sprites << {
      x: x,
      y: y,

      w: size,
      h: size,

      path: 'sprites/objects/lights/torch-animated.png',

      tile_x: frame * size,
      tile_y: 0,

      tile_w: size,
      tile_h: size
    }
  end

end