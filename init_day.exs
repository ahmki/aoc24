#!/usr/bin/env elixir

defmodule InitDay do
  @cookie "session=53616c7465645f5f483f05820a9899625752512f3e94da2068d947df72dd9ded771a95d8bdd066083816b92caa222471753e4aa86234e263a94a785694a9d412"

  def get_input(day) do

    start_deps()

    dir = "day#{day}"
    cookie_header = {~c"Cookie", @cookie}
    url = "https://adventofcode.com/2024/day/#{day}/input"

    case :httpc.request(:get, {url, [cookie_header]}, [], []) do
      {:ok, {{_, 200, _}, _, body}} ->
        write_to_file(dir, body)
        IO.puts("successfully saved input")

      {:ok, {{_, status, _}, _, body}} -> 
        IO.inspect(status)
        IO.inspect(body)

      {:error, reason} -> 
        IO.puts("Request failed: #{inspect(reason)}")
    end
  end

  defp write_to_file(dir, body) do
    File.mkdir_p(dir)
    File.write!("#{dir}/input.txt", body)
  end

  defp start_deps do
    :inets.start()
    :ssl.start()
  end
end

case System.argv do
  [day] -> 
    IO.puts("Initializing day #{day}")
    InitDay.get_input day

  _ -> IO.puts("usage: ./init_day.exs <day>")
end

