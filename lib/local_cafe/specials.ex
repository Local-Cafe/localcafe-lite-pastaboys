defmodule LocalCafe.Specials do
  alias LocalCafe.Specials.Item

  use NimblePublisher,
    build: Item,
    from: Application.app_dir(:local_cafe, "priv/specials/**/*.md"),
    as: :items,
    highlighters: []

  # Sort items by position (0-indexed, lower numbers first), then alphabetically by title.
  # Items without a position default to 999999 (appearing at the end).
  @items Enum.sort_by(@items, &{&1.position || 999999, &1.title})

  # Export items
  def all_items, do: @items
end
