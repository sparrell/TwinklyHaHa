defmodule TwinklyhahaWeb.TwinklyLive do
  @moduledoc "Live view for the LED"

  use TwinklyhahaWeb, :live_view

  @colors ["Violet", "Indigo", "Blue", "Green", "Yellow", "Orange", "Red"]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, led_on?: false, current_color: hd(@colors), colors: @colors)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div class="row">
    <div class="column column-50 column-offset-25">
        <%= for row <- 0..7 do %>
          <%= for _column <- 0..7 do %>
            <div class="led-box">
            <div class="led led-<%= if @led_on?, do: "on", else: "off" %>" <%= assign_color(assigns, @current_color, row) %> phx-hook="LedColor"></div>
            </div>
          <% end %>
            <br/ >
        <% end %>
        <%= if @led_on?, do: select_color(assigns) %>
        <div>
          <a class="button" phx-click="toggle-led">Turn LED <%= if @led_on?, do: "OFF", else: "ON" %> </a>
        </div>
      </div>
    </div>
    """
  end

  defp assign_color(assigns, "rainbow", row) do
    ~L"""
    data-ledcolor="<%= Stream.cycle(@colors) |> Enum.at(row) %>"
    """
  end

  defp assign_color(assigns, color, _row) do
    ~L"""
    data-ledcolor="<%= color %>"
    """
  end

  defp select_color(assigns) do
    # this is assigned here to stop it from updating the select list when colors is shifted to the right
    colors = @colors

    ~L"""
    <form phx-change="change-color">
      <select id="select-colors" name="color">
      <%= for color <- colors do %>
          <option value="<%= color %>" <%= if @current_color == color, do: "selected" %> >
            <%= color %>
          </option>
        <% end %>
      <option value="rainbow" <%= if @current_color == "rainbow", do: "selected" %> >
        Rainbow
      </option>
    </select>
    </form>
    """
  end

  @impl true
  def handle_event("toggle-led", _, socket) do
    socket = toggle_led(socket)
    color = hd(socket.assigns.colors)
    {:noreply, socket |> current_color(color, socket.assigns.led_on?)}
  end

  @impl true
  def handle_event("change-color", %{"color" => color}, socket) do
    {:noreply, current_color(socket, color, socket.assigns.led_on?)}
  end

  @impl true
  def handle_info(:shift_color, socket) do
    Process.send_after(self(), :shift_color, 100)
    {:noreply, shift_colors(socket)}
  end

  defp shift_colors(socket) do
    [hd | tail] = socket.assigns.colors
    assign(socket, :colors, tail ++ [hd])
  end

  defp current_color(socket, "rainbow", true) do
    Process.send_after(self(), :shift_color, 100)
    assign(socket, :current_color, "rainbow")
  end

  defp current_color(socket, _color, false = _led_on?) do
    assign(socket, :current_color, "rgba(0, 0, 0, 0.2)")
  end

  defp current_color(socket, color, true = _led_on?) do
    assign(socket, :current_color, color)
  end

  defp toggle_led(socket) do
    assign(socket, :led_on?, !socket.assigns.led_on?)
  end
end
