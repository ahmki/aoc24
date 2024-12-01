defmodule Day1 do
  def solve_dist do
    {left_values, right_values} = read_file()
    sorted_left = Enum.sort(left_values)
    sorted_right = Enum.sort(right_values)

    result =
      Stream.zip(sorted_left, sorted_right)
      |> Stream.map(fn {a, b} -> 
         abs(a - b)
      end)
      |> Enum.sum()

    IO.puts(result)
  end

  def solve_similarity do
    {left_values, right_values} = read_file()
    right_value_freqs = Enum.frequencies(right_values)

    result = 
      Enum.reduce(left_values, 0, fn curr, acc -> 
        curr * Map.get(right_value_freqs, curr, 0) + acc
      end)  
      
    IO.puts(result)
  end

  defp read_file do
    File.stream!("input.txt")
    |> Stream.map(fn line -> 
      [a, b] = 
        String.split(line) 
        |> Enum.map(&String.to_integer/1) 
      {a, b}
    end)
    |> Enum.unzip()
  end
end

Day1.solve_dist
Day1.solve_similarity
