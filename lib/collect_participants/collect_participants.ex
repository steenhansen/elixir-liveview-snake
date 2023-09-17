defmodule CollectParticipants do
  use GenServer

  # alias MultiGameWeb.LiveUser

  #  https://www.openmymind.net/Elixir-A-Little-Beyond-The-Basics-Part-8-genservers/

  #  https://stackoverflow.com/questions/48876826/using-a-genserver-in-phoenix-the-process-is-not-alive

  def start_link(_) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_) do
    no_games = Map.new()
    {:ok, no_games}
  end

  def handle_call({:get_participants, game_moniker}, _from_, all_games) do
    players_in_game = all_games[game_moniker]

    this_game =
      Map.filter(
        players_in_game,
        fn {user_name, pid_live} ->
          Process.alive?(pid_live)
        end
      )

    {:reply, this_game, all_games}
  end

  def get_participants(game_moniker) do
    GenServer.call(__MODULE__, {:get_participants, game_moniker})
  end

  def handle_cast({:add_participant, game_moniker, user_name, new_pid_live}, old_waiting) do
    ensure_game = Map.put_new(old_waiting, game_moniker, %{})

    games_users = ensure_game[game_moniker]

    added_user = Map.put(games_users, user_name, new_pid_live)
    new_waiting = Map.put(old_waiting, game_moniker, added_user)
    {:noreply, new_waiting}
  end

  def handle_cast({:clear_participants}, _old_waiting) do
    no_players = Map.new()
    {:noreply, no_players}
  end

  def add_participant(game_moniker, user_name, pid_live) do
    GenServer.cast(__MODULE__, {:add_participant, game_moniker, user_name, pid_live})
  end

  def clear_participants() do
    GenServer.cast(__MODULE__, {:clear_participants})
  end
end
