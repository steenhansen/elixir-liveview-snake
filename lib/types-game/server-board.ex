
  defmodule ServerBoard do
    use Norm

    defstruct board_width: 39,
              board_height: 38,
              board_empty_xys: MapSet.new([{0, 0}, {0, 1}, {1, 0}, {1, 1}]),
              board_fronts: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
              board_rumps: %{"1" => MapSet.new([]), "jill" => {0, 0}, "bob" => {3, 3}},
              board_walls: MapSet.new([{1, 1}, {2, 1}]),
              board_colors: %{"1" => 3, "jill" => 1, "bob" => 2},
              board_snakes_xys: %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12},
              board_ids: %{1 => "bob"},
              board_deads: %{"jill" => "bob"},
              board_jumps: %{"b3" => %{{0, 0} => 10, {1, 0} => 11, {2, 0} => 12}},
              board_leaps: Map.new()
  end

