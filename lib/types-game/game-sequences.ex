defmodule GameSequences do
  defstruct pid_board: nil,
            seq_step: "play_seq_1",
            seq_humans: Map.new(),
            seq_robots: Map.new(),
            seq_max_ping: 0,
            seq_winner_countdown: TheConsts.c_winner_wait(),
            seq_freeze_countdown: TheConsts.c_freeze_wait(),
            seq_scale: 1,
            seq_countdown: 3,
            seq_winner_front: {0, 0},
            seq_winner_name: "Bob",
            seq_match_choices: %MatchChosens{},
            seq_game_sizes: %GameSizes{}
       
end
