#  https://stackoverflow.com/questions/48378248/convert-list-of-maps-into-one-single-map

defmodule MapMerger do
  def merge(list_of_maps) do
    do_merge(list_of_maps, %{})
  end

  defp do_merge([], acc), do: acc

  defp do_merge([a_game_with_users | rest_games], acc) do
    game_and_users_list = Map.to_list(a_game_with_users)
    [{_game_name, list_of_users}] = game_and_users_list
    number_users = Enum.count(list_of_users)

    if number_users == 0 do
      # the game is empty of players so skip it
      do_merge(rest_games, acc)
    else
      updated_acc = Map.merge(acc, a_game_with_users)
      do_merge(rest_games, updated_acc)
    end
  end
end

# started from lib/multi_game/application.ex as a child process

defmodule CollectParticipants do
  use GenServer

  def clear_participants(game_name) do
    GenServer.cast(__MODULE__, {:clear_participants, game_name})
  end

  def start_link(_) do
    # db g({" The start of the GAME "})
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_) do
    no_games = Map.new()
    {:ok, no_games}
  end

  defp removeDead(all_browsers) do
    alive_list =
      for a_game_with_users <- all_browsers do
        {game_name, user_pid_to_name} = a_game_with_users

        alive_user_pids =
          for {pid_user, person_name} <- user_pid_to_name,
              Process.alive?(pid_user),
              into: %{} do
            {pid_user, person_name}
          end

        %{game_name => alive_user_pids}
      end
    still_alive = MapMerger.merge(alive_list)
    still_alive
  end

  def get_participants(game_name) do
    GenServer.call(__MODULE__, {:get_participants, game_name})
  end

  def handle_cast({:clear_participants, game_name}, old_collect) do
    new_m = Map.delete(old_collect, game_name)
    {:noreply, new_m}
  end

  def handle_cast({:add_participant, game_name, user_name, new_pid_user}, old_waiting) do
    ensure_game = Map.put_new(old_waiting, game_name, %{})
    games_users = ensure_game[game_name]
    added_user = Map.put(games_users, new_pid_user, user_name)
    new_waiting = Map.put(old_waiting, game_name, added_user)
    {:noreply, new_waiting}
  end

  def add_participant(game_name, user_name, pid_user) do
    GenServer.cast(__MODULE__, {:add_participant, game_name, user_name, pid_user})
  end

  def handle_call({:get_participants, name_of_game}, _from_, all_browsers) do
    alive_map = removeDead(all_browsers)
    players_in_game = alive_map[name_of_game]

    if players_in_game == nil do
      {:reply, %{}, alive_map}
    else
      number_users = Enum.count(players_in_game)

      if number_users == 0 do
        {:reply, %{}, alive_map}
      else
        browser_alive =
          Map.filter(
            players_in_game,
            fn {pid_user, _user_name} ->
              Process.alive?(pid_user)
            end
          )

        {:reply, browser_alive, alive_map}
      end
    end
  end
end
