defmodule RobotChange do
  defstruct change_front: {1, 2},
            change_rump: {3, 4},
            change_pid_user: "1",
            change_dead: false,
            change_jump: 0,
            change_leap: Map.new()
end