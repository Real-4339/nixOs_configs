local awful = require("awful")

local interval = 1  -- Обновление каждую секунду

awful.widget.watch('xkb-switch -p', interval, function(_, stdout)
    local lang = stdout:gsub("%s+", "")  -- Удаляем пробелы
    awesome.emit_signal("status::language", lang)
end)
