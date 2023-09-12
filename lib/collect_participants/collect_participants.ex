defmodule CollectParticipants do
  use GenServer

  #  https://www.openmymind.net/Elixir-A-Little-Beyond-The-Basics-Part-8-genservers/

  #  https://stackoverflow.com/questions/48876826/using-a-genserver-in-phoenix-the-process-is-not-alive

  def start_link(_) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(_) do
    no_players = Map.new()
    {:ok, no_players}
  end

  def handle_cast({:add_participant, game_moniker, the_name, pid_player}, old_waiting) do
    monikers = {game_moniker, the_name}
    new_waiting = Map.put(old_waiting, monikers, pid_player)

    still_alive =
      Map.filter(
        new_waiting,
        fn {_monikers, live_id} ->
          Process.alive?(live_id)
        end
      )

    {:noreply, still_alive}
  end

  def handle_cast({:clear_participants}, _old_waiting) do
    no_players = Map.new()
    {:noreply, no_players}
  end

  def add_participant(game_moniker, the_name, pid_player) do
    GenServer.cast(__MODULE__, {:add_participant, game_moniker, the_name, pid_player})
  end

  def clear_participants() do
    GenServer.cast(__MODULE__, {:clear_participants})
  end

  def handle_call({:get_participants}, _from_, waiting_players) do
    {:reply, waiting_players, waiting_players}
  end

  def get_participants() do
    GenServer.call(__MODULE__, {:get_participants})
  end
end
