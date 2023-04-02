defmodule LiveViewNativeSwiftUi.Types.Animation do
  @derive Jason.Encoder
  defstruct [:type, :properties, :modifiers]

  use LiveViewNativePlatform.Modifier.Type
  def type, do: :map

  def cast(type) when is_atom(type), do: {:ok, %__MODULE__{ type: type, properties: %{}, modifiers: [] }}
  def cast({type, [ {k, _} | _ ] = properties}) when is_atom(type) and is_atom(k) do
    {:ok, %__MODULE__{ type: type, properties: Enum.into(properties, %{}), modifiers: [] }}
  end
  def cast({type, [ {k, _} | _ ] = properties, modifiers}) when is_atom(type) and is_atom(k) and is_list(modifiers) do
    {:ok, %__MODULE__{ type: type, properties: Enum.into(properties, %{}), modifiers: Enum.map(modifiers, &cast_modifier/1) }}
  end

  def cast(_), do: :error

  def cast_modifier({type, properties}) when is_list(properties), do: %{ type: type, properties: Enum.into(properties, %{}) }
  def cast_modifier({type, properties}), do: %{ type: type, properties: properties }
end