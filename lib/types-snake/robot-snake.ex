
defmodule RobotSnake do
  defstruct robot_directions: ["down", "down", "down"],
            robot_number: 1,
            snake_front: {-1, -1},
            snake_rump: {7, 11},
            snake_xys_list: [],
            snake_dead: false
end