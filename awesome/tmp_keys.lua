local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local M = {}

modkey = "Mod4"

local terminal = "kitty" -- Обновлено на kitty

M.globalkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "r",
        function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "restore minimized", group = "client"}),
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}), -- Mod4 + Enter для терминала
    awful.key({ modkey }, "h", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}), -- Подсказка на Mod4 + H
    awful.key({ modkey }, "p", function () awful.spawn("dmenu_run") end,
              {description = "run dmenu", group = "launcher"}),
    awful.key({ modkey }, "f", function () awful.spawn("firefox") end,
              {description = "open firefox", group = "launcher"}),
    awful.key({ modkey }, "e", function () awful.spawn("thunar " .. os.getenv("HOME")) end,
              {description = "open thunar in home", group = "launcher"}),
    awful.key({ modkey }, "j", awful.client.focus.byidx(1),
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", awful.client.focus.byidx(-1),
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incmwfact(0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey }, "space", function () awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"})
)

M.clientkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"})
)

M.clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({modkey}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({modkey}, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Привязка клавиш к тегам (1-9)
for i = 1, 9 do
    M.globalkeys = gears.table.join(M.globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         tag:view_only()
                      end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                      end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- Глобальные привязки мыши для переключения тегов
M.globalbuttons = gears.table.join(
    awful.button({modkey, "Shift"}, 4, awful.tag.viewnext), -- Mod4 + Shift + колесико вперед
    awful.button({modkey, "Shift"}, 5, awful.tag.viewprev)  -- Mod4 + Shift + колесико назад
)

return M
