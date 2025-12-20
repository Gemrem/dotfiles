local APP_NAME = "Alacritty"

hs.hotkey.bind({"cmd","shift"}, "T", function()
  local app = hs.application.find(APP_NAME)

  if not app then
    -- Not running → launch it
    hs.application.launchOrFocus(APP_NAME)
    return
  end

  if app:isFrontmost() then
    -- Visible → hide
    app:hide()
  else
    -- Hidden or background → show
    app:activate(true)
  end
end)
