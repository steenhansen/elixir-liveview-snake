defmodule S do
  use Norm

  @doc """
    iex.bat -S mix phx.server

    S.isa_xy_tuple({1, 2})


  """

  def typeof(a) do
    cond do
      is_float(a) -> "float"
      is_number(a) -> "number"
      is_atom(a) -> "atom"
      is_boolean(a) -> "boolean"
      is_binary(a) -> "binary"
      is_function(a) -> "function"
      is_list(a) -> "list"
      is_tuple(a) -> "tuple"
      true -> "idunno"
    end
  end

  @doc """
    S.isa_xy_tuple({1, 2})

    S.isa_xy_tuple("Bart")  ===  not a tuple "Bart"
    S.isa_xy_tuple({1,2,3})  ===  not 2 elements {1, 2, 3}
    S.isa_xy_tuple({1,"a"})  === not 2 integers {1, "a"}
    S.isa_xy_tuple({1, 999999})  === not valid integer values {1, 999999}
  """

  def isa_xy_tuple(xy_tuple) do
    bad_tuple = Kernel.inspect(xy_tuple)

    if !is_tuple(xy_tuple) do
      raise ArgumentError, message: "not a tuple " <> bad_tuple
    else
      if tuple_size(xy_tuple) != 2 do
        raise ArgumentError, message: "not 2 elements " <> bad_tuple
      else
        {x, y} = xy_tuple

        if is_integer(x) and is_integer(y) do
          if x in 0..44 and y in 0..44 do
            true
          else
            raise ArgumentError, message: "not valid integer values " <> bad_tuple
          end
        else
          raise ArgumentError, message: "not 2 integers " <> bad_tuple
        end
      end
    end
  end

  @doc """
    S.struct_name( %XySvg{svgCss_icon_ind: 0, svgCss_css_jump: "no-jump"} ) === "XySvg"

    S.struct_name(12) === "not a struct 12"
  """
  def struct_name(a_struct) do
    if !is_struct(a_struct) do
      raise ArgumentError, message: "not a struct " <> Kernel.inspect(a_struct)
    else
      %struct_name{} = a_struct
      str_name = to_string(struct_name)
      the_names = String.split(str_name, ".")
      List.last(the_names)
    end
  end

  @doc """
      S.isa_xySvg_struct( %XySvg{svgCss_icon_ind: 0, svgCss_css_jump: "no-jump"} )

      S.isa_xySvg_struct( %{} ) === not a struct %{}
      S.isa_xySvg_struct( %JumpSlice{} ) ===  wrong struct JumpSlice
      S.isa_xySvg_struct( %XySvg{svgCss_icon_ind: "xyz", svgCss_css_jump: "no-jump"} ) ===  bad svgCss_icon_ind value xyz
      S.isa_xySvg_struct( %XySvg{svgCss_icon_ind: 0, svgCss_css_jump: 123} ) ===  bad svgCss_css_jump value 123
  """
  def isa_xySvg_struct(xySvg_struct) do
    struct_name = struct_name(xySvg_struct)

    if struct_name != "XySvg" do
      raise ArgumentError, message: "wrong struct " <> struct_name
    else
      %XySvg{svgCss_icon_ind: icon_ind, svgCss_css_jump: css_jump} = xySvg_struct

      if !is_integer(icon_ind) or !(icon_ind in 0..98) do
        raise ArgumentError, message: "bad svgCss_icon_ind value " <> Kernel.inspect(icon_ind)
      else
        if !is_binary(css_jump) do
          raise ArgumentError, message: "bad svgCss_css_jump value " <> Kernel.inspect(css_jump)
        else
          true
        end
      end
    end
  end

  @doc """
    S.isa_xy_to_SvgCss(%{ {38, 2} => %XySvg{svgCss_icon_ind: 0, svgCss_css_jump: "no-jump"}})

    S.isa_xy_to_SvgCss(13) === not a map
    S.isa_xy_to_SvgCss(%{ {1, 26} => {0, 3} }) === not a struct {0, 3}
  """
  def isa_xy_to_SvgCss(my_map) do
    if !is_map(my_map) do
      raise ArgumentError, message: "not a map"
    else
      my_map
      |> Enum.map(fn {xy_coord, xy_svg} ->
        isa_xy_tuple(xy_coord)
        isa_xySvg_struct(xy_svg)
      end)

      true
    end
  end

  @doc """
    S.isa_xy_set(MapSet.new([ {20, 30},{18, 29} ]))

    S.isa_xy_set(1492) === not a mapset
    S.isa_xy_set(MapSet.new([ {20, "animal"} ])) == not 2 integers {20, "animal"}
  """
  def isa_xy_set(is_mapSet) do
    if !isa_mapSet(is_mapSet) do
      raise ArgumentError, message: "not a mapset"
    else
      is_mapSet
      |> Enum.map(fn xy_coord ->
        isa_xy_tuple(xy_coord)
      end)

      true
    end
  end

  @doc """
    S.isa_mapSet(%MapSet{})
    S.isa_mapSet(MapSet.new([ {20, 30},{18, 29} ]))

     S.isa_mapSet(14) ===  not a struct 14
     S.isa_mapSet(%{}) === not a struct %{}
  """
  def isa_mapSet(a_mapset) do
    if !is_struct(a_mapset) do
      false
    else
      %struct_name{} = a_mapset
      str_name = to_string(struct_name)
      the_names = String.split(str_name, ".")
      mapset_name = List.last(the_names)
      mapset_name == "MapSet"
    end
  end

  ####################### use below in @contracts
  def is_a_xy_to_SvgCss(), do: spec(fn my_map -> S.isa_xy_to_SvgCss(my_map) end)
  def is_a_xy_set(), do: spec(fn my_map -> S.isa_xy_set(my_map) end)

  def is_a_pid(), do: spec(is_pid())

  def is_a_1_2_3(), do: spec(is_integer() and (&(&1 in 1..3)))

  def is_a_coord(), do: spec(is_integer() and (&(&1 in 0..44)))

  def is_a_color_int(), do: spec(is_integer() and (&(&1 in 1..9)))
end
