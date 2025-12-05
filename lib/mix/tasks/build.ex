defmodule Mix.Tasks.Build do
  use Mix.Task
  @impl Mix.Task
  def run(_args) do
    # Ensure the application and dependencies are started
    Mix.Task.run("app.start")

    {micro, :ok} =
      :timer.tc(fn ->
        LocalCafe.build()
      end)

    ms = micro / 1000
    IO.puts("BUILT in #{ms}ms")
  end
end
