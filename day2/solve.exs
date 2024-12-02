defmodule Day2 do
  def find_safe do
    list = read_file()

    safely_increasing = Enum.map(list, fn c -> 
      safe?(c, :increasing) 
    end)
    safely_decreasing = Enum.map(list, fn c -> 
      safe?(c, :decreasing)
    end)
    
    zip = Enum.zip_with(safely_increasing, safely_decreasing, fn x, y -> x || y end)

    resultfinal = Enum.frequencies(zip)
    IO.inspect(resultfinal)
  end

  def find_safe_with_dampener do
    list = read_file()

    bruteforce = Enum.map(list, fn line -> 
      hate_it_low_iq = for i <- 0..length(list), do: List.delete_at(line, i)
      Enum.any?(hate_it_low_iq, fn x -> safe?(x, :increasing) end) || Enum.any?(hate_it_low_iq, fn x -> safe?(x, :decreasing) end)
    end)

    Enum.frequencies(bruteforce)
  end

  def safe?(list, :increasing) do
    Enum.chunk_every(list, 2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a < b && abs(a - b) <= 3 end)
  end

  def safe?(list, :decreasing) do
    Enum.chunk_every(list, 2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a > b && abs(a - b) <= 3 end)
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

# Day2.find_safe()
Day2.find_safe_with_dampener()

