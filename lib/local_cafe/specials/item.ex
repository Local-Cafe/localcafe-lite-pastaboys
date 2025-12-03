defmodule LocalCafe.Specials.Item do
  @enforce_keys [:title, :body, :description, :path, :prices]
  defstruct [:title, :body, :description, :prices, :path, :image, :position]

  def build(filename, attrs, body) do
    [_, file] =
      String.split(Path.rootname(filename), Application.app_dir(:local_cafe, "priv"))

    struct!(__MODULE__, [body: body, path: Path.rootname(file) <> ".html"] ++ Map.to_list(attrs))
  end
end
