#  https://stackoverflow.com/questions/48378248/convert-list-of-maps-into-one-single-map

# https://stackoverflow.com/questions/39383209/pattern-matching-on-a-map-with-variable-as-key
#   %{"brother-game" => %{}}  =====>>>>> [ "brother-game", %{} ]
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

  # alias MultiGameWeb.UserHtml

  #  https://www.openmymind.net/Elixir-A-Little-Beyond-The-Basics-Part-8-genservers/

  #  https://stackoverflow.com/questions/48876826/using-a-genserver-in-phoenix-the-process-is-not-alive

  def start_link(_) do
    dbg({" The start of the GAME "})
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_) do
    no_games = Map.new()
    {:ok, no_games}
  end

  defp removeDead(all_browsers) do

    alive_list =
      for a_game_with_users <- all_browsers do
        {game_name, user_pids} = a_game_with_users

        the_users =
          for {user_name, pid} <- user_pids,
              Process.alive?(pid),
              into: %{} do
            {user_name, pid}
          end

        %{game_name => the_users}
      end

    MapMerger.merge(alive_list)
  end

  def handle_call({:get_participants, name_of_game}, _from_, all_browsers) do
    alive_map = removeDead(all_browsers)
    players_in_game = alive_map[name_of_game]

    browser_alive =
      Map.filter(
        players_in_game,
        fn {_user_name, pid_user} ->
          Process.alive?(pid_user)
        end
      )

    {:reply, browser_alive, alive_map}
  end

  def get_participants(game_name) do
    GenServer.call(__MODULE__, {:get_participants, game_name})
  end

  def handle_cast({:clear_participants}, _old_waiting) do
    no_players = Map.new()
    {:noreply, no_players}
  end

  def handle_cast({:add_participant, game_name, user_name, new_pid_user}, old_waiting) do
    ensure_game = Map.put_new(old_waiting, game_name, %{})
    games_users = ensure_game[game_name]
    added_user = Map.put(games_users, user_name, new_pid_user)
    new_waiting = Map.put(old_waiting, game_name, added_user)
    {:noreply, new_waiting}
  end

  def add_participant(game_name, user_name, pid_user) do
    GenServer.cast(__MODULE__, {:add_participant, game_name, user_name, pid_user})
  end

  def clear_participants() do
    GenServer.cast(__MODULE__, {:clear_participants})
  end
end
