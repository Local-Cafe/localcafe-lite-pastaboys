defmodule LocalCafe.Locations.Location do
  @enforce_keys [:name, :body, :street, :city_state, :phone, :email, :hours]
  defstruct [:name, :body, :street, :city_state, :phone, :email, :hours, :image]

  def build(_filename, attrs, body) do
    struct!(__MODULE__, [body: body] ++ Map.to_list(attrs))
  end
end
