defmodule Day2 do
  def find_safe do
    list = read_file()

    result = Enum.frequencies(Enum.map(list, fn c -> 
      safe?(c) 
    end))

    IO.inspect(result, label: "Solution 1")
  end

  def find_safe_with_dampener do
    list = read_file()

    bruteforce = Enum.map(list, fn line -> 
      all_possible_removes = 
        Enum.with_index(list)
        |> Enum.map(fn {_, i} -> List.delete_at(line, i) end)

      Enum.any?(all_possible_removes, fn line -> safe?(line) end) 
    end)

    IO.inspect(Enum.frequencies(bruteforce), label: "Solution")
  end

  def safe?(list) do
    case list do
      [a, b | _] -> 
        direction = if a < b, do: :increasing, else: :decreasing

        Enum.chunk_every(list, 2, 1, :discard)
        |> Enum.all?(fn [x, y] -> 
          case direction do
            :increasing -> x < y && abs(x - y) <= 3
            :decreasing -> x > y && abs(x - y) <= 3
          end
        end)

      _ -> true
    end
  end

  defp read_file do
    File.stream!("input.txt")
    |> Stream.map(&String.split/1)
    |> Stream.map(fn x -> 
      Enum.map(x, fn x -> String.to_integer(x) end)
    end)
    |> Enum.to_list()
  end
end

Day2.find_safe()
Day2.find_safe_with_dampener()

