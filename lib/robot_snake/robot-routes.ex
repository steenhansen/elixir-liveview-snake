defmodule RobotRoutes do
  def left_s_9, do: "LLLLLLLLL"
  def right_s_9, do: "RRRRRRRRR"
  def up_s_9, do: "UUUUUUUUU"
  def down_s_9, do: "DDDDDDDDD"

  # def clockwise_10, do: "DRDRRDRDDLDLLDLLULLULUURURRURURR"

  def left_a_6, do: "LLLLLL"
  def right_a_6, do: "RRRRRR"
  def up_a_6, do: "UUUUUU"
  def down_a_6, do: "DDDDDD"

  # def the_l, do: "DDDLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
  def left_c_3, do: "LLL"
  def right_c_3, do: "RRR"
  def up_c_3, do: "UUU"
  def down_c_3, do: "DDD"

  def going_up_s_routes, do: [left_s_9(), right_s_9(), up_s_9()]
  def going_up_a_routes, do: [left_a_6(), right_a_6(), up_a_6()]
  def going_up_c_routes, do: [left_c_3(), right_c_3(), up_c_3()]

  def going_right_s_routes, do: [right_s_9(), up_s_9(), down_s_9()]
  def going_right_a_routes, do: [right_a_6(), up_a_6(), down_a_6()]
  def going_right_c_routes, do: [right_c_3(), up_c_3(), down_c_3()]

  def going_down_s_routes, do: [left_s_9(), right_s_9(), down_s_9()]
  def going_down_a_routes, do: [left_a_6(), right_a_6(), down_a_6()]
  def going_down_c_routes, do: [left_c_3(), right_c_3(), down_c_3()]

  def going_left_s_routes, do: [left_s_9(), up_s_9(), down_s_9()]
  def going_left_a_routes, do: [left_a_6(), up_a_6(), down_a_6()]
  def going_left_c_routes, do: [left_c_3(), up_c_3(), down_c_3()]

  def going_up_routes(chosen_movement) do
    case chosen_movement do
      "movement-simple" -> going_up_s_routes()
      "movement-average" -> going_up_a_routes()
      "movement-complex" -> going_up_c_routes()
    end
  end

  def going_right_routes(chosen_movement) do
    case chosen_movement do
      "movement-simple" -> going_right_s_routes()
      "movement-average" -> going_right_a_routes()
      "movement-complex" -> going_right_c_routes()
    end
  end

  def going_left_routes(chosen_movement) do
    case chosen_movement do
      "movement-simple" -> going_left_s_routes()
      "movement-average" -> going_left_a_routes()
      "movement-complex" -> going_left_c_routes()
    end
  end

  def going_down_routes(chosen_movement) do
    case chosen_movement do
      "movement-simple" -> going_down_s_routes()
      "movement-average" -> going_down_a_routes()
      "movement-complex" -> going_down_c_routes()
    end
  end

  # simple complicated sneaky
end
