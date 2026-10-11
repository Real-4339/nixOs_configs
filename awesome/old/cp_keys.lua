local gears = require("gears")
local awful = require("awful")
-- Не забудьте require другие модули, если они нужны для ваших команд
-- Пример: local naughty = require("naughty")

local M = {}

-- Default modkey.
-- В AwesomeWM принято определять modkey как глобальную переменную,
-- чтобы она была доступна в других частях конфигурации (например, в taglist).
-- Если вы хотите строго модульный подход, то передавайте modkey явно.
-- Но для совместимости с существующей конфигурацией, оставим так.
modkey = "Mod4"
-- Если вы хотите, чтобы modkey был доступен только в этом модуле, используйте:
-- local modkey = "Mod4"
-- И затем передавайте его в функции или используйте M.modkey

-- Переменные для команд, если они часто используются
local terminal = "alacritty" -- Вынесем, чтобы не дублировать, если terminal в rc.lua изменится

-- {{{ Key bindings
M.globalkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "r",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end,
    { description = "restore minimized", group = "client" }),

    -- СЮДА НУЖНО ДОБАВИТЬ ВАШИ ГЛОБАЛЬНЫЕ ГОРЯЧИЕ КЛАВИШИ ИЗ SXHKDRC
    -- Пример: запуск терминала
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    -- Пример: запуск rofi (или другого лаунчера)
    -- awful.key({ modkey,           }, "p", function () awful.spawn("rofi -show drun") end,
    --           {description = "show rofi drun", group = "launcher"}),

    -- Управление громкостью (пример, если у вас pactl или pamixer)
    -- awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
    --           {description = "volume up", group = "sound"}),
    -- awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
    --           {description = "volume down", group = "sound"}),
    -- awful.key({ }, "XF86AudioMute", function () awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
    --           {description = "toggle mute", group = "sound"}),

    -- Управление яркостью (пример, если у вас brightnessctl или xbacklight)
    -- awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.with_shell("brightnessctl set +10%") end,
    --           {description = "brightness up", group = "display"}),
    -- awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.with_shell("brightnessctl set 10%-") end,
    --           {description = "brightness down", group = "display"}),

    -- Стандартные бинды Awesome для управления тегами и клиентами
    -- (многие из них обычно определяются в цикле, но для примера можно и так)
    awful.key({ modkey,           }, "j",   awful.client.focus.byidx( 1),
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k",   awful.client.focus.byidx(-1),
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"})

    -- Добавьте бинды для переключения тегов (1-9)
    -- Это часто делается в цикле в rc.lua при создании тегов, но можно и здесь
    -- for i = 1, 9 do
    --     M.globalkeys = gears.table.join(M.globalkeys,
    --         -- View tag only.
    --         awful.key({ modkey }, "#" .. i + 9,
    --                   function ()
    --                         local screen = awful.screen.focused()
    --                         local tag = screen.tags[i]
    --                         if tag then
    --                            tag:view_only()
    --                         end
    --                   end,
    --                   {description = "view tag #"..i, group = "tag"}),
    --         -- Toggle tag display.
    --         awful.key({ modkey, "Control" }, "#" .. i + 9,
    --                   function ()
    --                       local screen = awful.screen.focused()
    --                       local tag = screen.tags[i]
    --                       if tag then
    --                          awful.tag.viewtoggle(tag)
    --                       end
    --                   end,
    --                   {description = "toggle tag #" .. i, group = "tag"}),
    --         -- Move client to tag.
    --         awful.key({ modkey, "Shift" }, "#" .. i + 9,
    --                   function ()
    --                       if client.focus then
    --                           local tag = client.focus.screen.tags[i]
    --                           if tag then
    --                               client.focus:move_to_tag(tag)
    --                           end
    --                      end
    --                   end,
    --                   {description = "move focused client to tag #"..i, group = "tag"}),
    --         -- Toggle tag on focused client.
    --         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    --                   function ()
    --                       if client.focus then
    --                           local tag = client.focus.screen.tags[i]
    --                           if tag then
    --                               client.focus:toggle_tag(tag)
    --                           end
    --                       end
    --                   end,
    --                   {description = "toggle focused client on tag #" .. i, group = "tag"})
    --     )
    -- end
)

M.clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"})
    -- Добавьте другие бинды для управления окнами, если нужно
)

-- Bind all key numbers to tags.
-- Be careful: some layouts use this for keyboard navigation.
for i = 1, 9 do
    M.globalkeys = gears.table.join(M.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, -- Это цифры 1-9 на основной клавиатуре, не numpad
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Move client to tag.
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


M.clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

return M
