defmodule ListToXy do
 
  def makeARow(players_matrix, x_range, the_row) do
      #   dbg({"77", players_matrix})
    for x <- 0..x_range, into: %{} do
      color = players_matrix[{x, the_row}]
      {x, color}
    end
  end

  @doc since: """
                 https://hexdocs.pm/arrays/Arrays.html

                   players_matrix = %{  {0, 0} => 0,  {1, 0} => 10,  {2, 0} => 20,
                                       {0, 1} => 1,  {1, 1} => 11,  {2, 1} => 21,
                                       {0, 2} => 2,  {1, 2} => 12,  {2, 2} => 22   }

                   MultiGameWeb.LiveUser.makeAllRows(players_matrix, 2, 2)

                %{0, %{0 => 0, 1 => 10, 2 => 20}},
                 {1, %{0 => 1, 1 => 11, 2 => 21}},
                 {2, %{0 => 2, 1 => 12, 2 => 22}}

       """
  def makeAllRows(players_matrix, x_range, y_range) do
       #  dbg({"66", players_matrix})
    for y <- 0..y_range, into: %{} do
      the_row = makeARow(players_matrix, x_range, y)
      {y, the_row}
    end
  end

  
end
