defmodule LocalCafe.MapDownloader do
  @moduledoc """
  Downloads static map images at build time for locations.
  """

  @output_dir Application.app_dir(:local_cafe, "priv/output/images/maps")

  def download_map(location) do
    unless location.latitude && location.longitude do
      {:error, :no_coordinates}
    else
      download_map_with_coords(location)
    end
  end

  defp download_map_with_coords(location) do

    # Ensure output directory exists
    File.mkdir_p!(@output_dir)

    # Generate filename from location name
    filename = slugify(location.name) <> ".png"
    output_path = Path.join(@output_dir, filename)

    # Skip if already downloaded
    if File.exists?(output_path) do
      {:ok, "/images/maps/#{filename}"}
    else
      case fetch_map_image(location.latitude, location.longitude) do
        {:ok, image_data} ->
          File.write!(output_path, image_data)
          {:ok, "/images/maps/#{filename}"}

        {:error, reason} ->
          IO.puts("Warning: Failed to download map for #{location.name}: #{inspect(reason)}")
          {:error, reason}
      end
    end
  end

  defp fetch_map_image(lat, lon) do
    # Convert to float if string
    lat_float = if is_binary(lat), do: String.to_float(lat), else: lat
    lon_float = if is_binary(lon), do: String.to_float(lon), else: lon

    # Build list of services to try
    services = build_service_list(lat_float, lon_float)
    fetch_from_services(services)
  end

  defp build_service_list(lat, lon) do
    # Download a 2x2 grid of tiles centered on the location
    zoom = 15

    # Get the exact tile coordinates including fractional part
    lat_rad = lat * :math.pi() / 180
    n = :math.pow(2, zoom)
    x_exact = (lon + 180.0) / 360.0 * n
    y_exact = (1.0 - :math.log(:math.tan(lat_rad) + 1 / :math.cos(lat_rad)) / :math.pi()) / 2.0 * n

    # Calculate which tiles to download so location is at center (256, 256)
    # We want the location to be at the intersection of 4 tiles
    # For a 2x2 grid, center is at (base + 1.0) in tile coordinates
    # So we need: x_exact ≈ base_x + 1.0, therefore base_x = round(x_exact - 1.0)
    base_x = round(x_exact - 1.0)
    base_y = round(y_exact - 1.0)

    # Create 2x2 grid with location at center
    tiles = for x <- [base_x, base_x + 1],
                y <- [base_y, base_y + 1] do
      {x, y, "https://tile.openstreetmap.org/#{zoom}/#{x}/#{y}.png"}
    end

    {:stitch, tiles}
  end

  defp fetch_from_services({:stitch, tiles}) do
    # Download all tiles
    downloaded_tiles = Enum.map(tiles, fn {x, y, url} ->
      case Req.get(url, headers: [{"user-agent", "LocalCafe Static Site Generator"}], receive_timeout: 30000) do
        {:ok, %{status: 200, body: body}} ->
          {:ok, {x, y, body}}
        error ->
          error
      end
    end)

    # Check if all downloads succeeded
    if Enum.all?(downloaded_tiles, fn result -> match?({:ok, _}, result) end) do
      tiles_data = Enum.map(downloaded_tiles, fn {:ok, data} -> data end)
      stitch_tiles(tiles_data)
    else
      {:error, :download_failed}
    end
  end

  defp fetch_from_services([url | rest]) do
    case Req.get(url, headers: [{"user-agent", "LocalCafe Static Site Generator"}], receive_timeout: 30000) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %{status: status}} ->
        IO.puts("  Service returned #{status}, trying next...")
        if rest != [], do: fetch_from_services(rest), else: {:error, {:http_error, status}}

      {:error, _reason} when rest != [] ->
        fetch_from_services(rest)

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp stitch_tiles(tiles_data) do
    # Sort tiles by coordinates to arrange them properly (2x2 grid)
    sorted_tiles = Enum.sort_by(tiles_data, fn {x, y, _body} -> {y, x} end)

    # Load images
    images = Enum.map(sorted_tiles, fn {_x, _y, body} ->
      {:ok, img} = Image.from_binary(body)
      img
    end)

    # Stitch into 2x2 grid (512x512)
    # Row 1: tiles 0 and 1 side by side
    # Row 2: tiles 2 and 3 side by side
    {:ok, row1} = Image.join([Enum.at(images, 0), Enum.at(images, 1)], across: 2)
    {:ok, row2} = Image.join([Enum.at(images, 2), Enum.at(images, 3)], across: 2)
    {:ok, final} = Image.join([row1, row2])

    # Convert back to PNG binary
    {:ok, binary} = Image.write(final, :memory, suffix: ".png")
    {:ok, binary}
  end


  defp slugify(string) do
    string
    |> String.downcase()
    |> String.replace(~r/[^\w\s-]/, "")
    |> String.replace(~r/[\s_-]+/, "-")
    |> String.trim("-")
  end
end
