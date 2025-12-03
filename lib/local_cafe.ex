defmodule LocalCafe do
  use Phoenix.Component
  import Phoenix.HTML

  alias LocalCafe.Menu
  alias LocalCafe.Site
  alias LocalCafe.Location

  embed_templates("templates/*")

  @output_dir Application.app_dir(:local_cafe, "priv/output")

  def build() do
    items = Menu.all_items()
    tags = Menu.all_tags()
    locations = Location.all_locations()

    render_file(
      "index.html",
      index(%{
        items: items,
        tags: tags,
        site_settings: Site.site_settings(),
        locations: locations
      })
    )

    for item <- items do
      dir = Path.dirname(item.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(
        item.path,
        item(%{item: item, site_settings: Site.site_settings(), locations: locations})
      )
    end

    :ok
  end

  def page_description(assigns) do
    assigns[:description] || assigns.site_settings.description
  end

  def page_image(assigns) do
    assigns[:image] || assigns.site_settings.image
  end

  defp render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end

  defp path(assigns, path) do
    # Extract base path from domain (e.g., "https://user.github.io/repo" -> "/repo")
    base =
      case Map.get(assigns.site_settings, :domain) do
        nil ->
          ""

        domain ->
          uri = URI.parse(domain)
          uri.path || ""
      end

    # Ensure base doesn't end with / and path starts with /
    base = String.trim_trailing(base, "/")
    path = if String.starts_with?(path, "/"), do: path, else: "/#{path}"
    "#{base}#{path}"
  end

  defp full_url(assigns, path) do
    case Map.get(assigns.site_settings, :domain) do
      nil ->
        path

      domain ->
        uri = URI.parse(domain)
        base_path = String.trim_trailing(uri.path || "", "/")
        clean_path = if String.starts_with?(path, "/"), do: path, else: "/#{path}"

        # Build full URL with scheme and host
        %URI{uri | path: "#{base_path}#{clean_path}"}
        |> URI.to_string()
    end
  end
end
