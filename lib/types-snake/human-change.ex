defmodule HumanChange do
  defstruct change_front: {1, 2},
            change_rump: {3, 4},
            change_pid_user: nil,
            change_dead: false,
            change_jump: 0,
            change_leap: %{{1, 0} => %{"slice_vertical" => false, "slice_start" => false}}
end