defmodule HumanSnake do
  defstruct human_direction: "up",
            human_name: "human_nameX",
            snake_front: {-1, -1},
            snake_rump: {7, 11},
            snake_xys_list: [],
            snake_dead: false,
            human_jump: 0,
            human_leap: Map.new(),
            game_name: "game-name",
            human_pid_user: nil
end