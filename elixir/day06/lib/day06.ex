defmodule Day06 do
  def parse_line(line) do
    # turn off 660,55 through 986,197
    # turn on 660,55 through 986,197
    splitted = String.split(line, " ")
    {turn_on, splitted, toggle} = if Enum.take(splitted, 1) == ["turn"] do
      {Enum.at(splitted, 1) == "on", Enum.drop(splitted, 2), false}
    else
      {false, Enum.drop(splitted, 1), true}
    end
    from = Enum.at(splitted, 0) |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple
    to = Enum.at(splitted, 2) |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple
    {toggle, turn_on, from, to}
  end

  def overlapping?(from, to, status, box) do
    {{bxfrom, byfrom}, {bxto, byto}, boxstatus} = box
    if boxstatus == status do
      false
    else
      {fromx, fromy} = from
      {tox, toy} = to
      not (fromx > bxto or fromy > byto or tox < bxfrom or toy < byfrom)
    end
  end

  def split_x(from, to, status, box) do
    {{bxfrom, byfrom}, {bxto, byto}, boxstatus} = box
    {fromx, fromy} = from
    {tox, toy} = to
    new_boxes = if bxfrom < fromx and fromx <= bxto do
      # split head
      head = {{bxfrom, byfrom}, {fromx-1, byto}, boxstatus}
      if fromx <= bxto and tox <= bxto do
        middle = {{fromx, byfrom}, {tox, byto}, status}
        bottom = {{tox+1, byfrom}, {bxto, byto}, boxstatus}
        [head, middle, bottom]
      else
        middle = {{fromx, byfrom}, {bxto, byto}, status}
        [head, middle]
      end
    else
      if tox < bxto do
        head = {{bxfrom, byfrom}, {tox, byto}, status}
        bottom = {{tox+1, byfrom}, {bxto, byto}, boxstatus}
        [head, bottom]
      else
        [{{bxfrom, byfrom},{bxto, byto}, status}]
      end
    end
    new_boxes
  end

  def swap({x, y}) do
    {y, x}
  end

  def swap_box({{x1, y1}, {x2, y2}, status}) do
    {{y1, x1}, {y2, x2}, status}
  end

  def split_y(from, to, status, box) do
    split_x(swap(from), swap(to), status, swap_box(box))
    |> Enum.map(&swap_box/1)
  end

  def split(from, to, status, box) do
    new_boxes = split_x(from, to, status, box)
    Enum.reduce(new_boxes, [], fn(box, new_boxes) ->
      {a,b,x} = box
      if x == status do
        c = split_y(from, to, status, {a,b,not x})
        new_boxes ++ c
      else
        new_boxes ++ [box]
      end
    end)
  end

  def reduce_line({toggle, turn_on, from, to}, boxes) do
    Enum.reduce(boxes, [], fn(box, new_boxes) ->
      {_,_,old_status} = box
      status = if toggle, do: not old_status, else: turn_on
      if overlapping?(from, to, status, box) do
        # wenn overlapping, dann splitte die box und für die neuen boxen hinzu
        split(from, to, status, box) ++ new_boxes
      else
        # wenn kein overlapping, füge die box wieder hinzu
        [box | new_boxes]
      end
    end)
  end

  def part01() do
    File.read!("input.txt")
    |> String.trim
    |> String.split("\n", [trim: true])
    |> Enum.map(&parse_line/1)
    |> Enum.reduce([{{0,0},{999,999},false}], &reduce_line/2)
    |> Enum.filter(fn ({_,_,status}) -> status end)
    |> Enum.reduce(0, fn ({{fromx, fromy}, {tox, toy}, status}, counter) ->
      counter + (tox - fromx + 1) * (toy - fromy + 1)
    end)
  end

  def main(_) do
    IO.puts "Hello World"
    part01() |> IO.inspect
  end
end
