local wibox = require("wibox")
local beautiful = require("beautiful")
require("status.language")

local lang_map = {
    ["us"] = "EN",
    ["ru"] = "RU",
    -- Добавьте другие языки при необходимости
}

local language = wibox.widget {
    widget = wibox.widget.textbox
}

awesome.connect_signal("status::language", function(lang)
    local display_lang = lang_map[lang] or lang
    language.font = beautiful.font
    local markup = "<span foreground='#FFFFFF'>" .. display_lang .. "</span>"
    language.markup = markup
end)

return language
