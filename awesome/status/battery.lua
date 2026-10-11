-- status/battery.lua
local awful = require("awful")
local beautiful = require("beautiful")

local interval = beautiful.battery_check_interval or 10

awful.widget.watch("acpi -b", interval, function(_, stdout, stderr, exitreason, exitcode) -- Используем acpi -b для большей специфичности
    print("------------------------------------") -- Разделитель для логов
    print("[STATUS_BATTERY] Watch triggered.")
    print("[STATUS_BATTERY] stdout: [" .. stdout .. "]")
    print("[STATUS_BATTERY] stderr: [" .. (stderr or "nil") .. "]")
    print("[STATUS_BATTERY] exitcode: " .. tostring(exitcode))

    if exitcode ~= 0 or stdout == nil or stdout == "" then
        print("[STATUS_BATTERY] Error or empty output from acpi. stderr: " .. (stderr or "N/A"))
        -- Можно эмитить сигнал с nil или специальным значением ошибки, чтобы виджет это показал
        -- awesome.emit_signal("status::battery", nil, nil)
        return
    end

    local capacity = nil
    local charging = false

    -- Твой оригинальный парсинг:
    local cap_match = string.match(stdout, "(%d?%d?%d)%%")
    if cap_match then
        capacity = tonumber(cap_match)
    end
    print("[STATUS_BATTERY] Parsed capacity: ", capacity)

    -- Твой оригинальный парсинг статуса:
    -- "Battery 0: Charging, 80%, ..."
    -- "Battery 0: Discharging, 80%, ..."
    -- "Battery 0: Full, 100%, ..." (может быть как charging=true, так и charging=false если адаптер отключен)
    -- "Battery 0: Unknown, 80%, ..."
    local status_str = string.match(stdout, "Battery %d+:%s*([%w ]+),") -- %d+ для номера батареи, %s* для пробелов
    print("[STATUS_BATTERY] Parsed status_str: ", status_str)

    if status_str then
        if string.find(status_str, "Charging") then
            charging = true
        elseif string.find(status_str, "Full") then
            -- Если "Full", acpi обычно означает, что батарея не разряжается.
            -- Она может быть на зарядке (и заряжена) или просто полностью заряжена и адаптер подключен.
            -- Если НЕТ слова "Discharging", то считаем, что она "не разряжается", что близко к charging=true
            -- (или по крайней мере не discharging).
            if not string.find(status_str, "Discharging") then
                 charging = true -- Будем считать 'Full' как состояние "не разряжается"
            else
                 charging = false -- Если вдруг "Full, Discharging"
            end
        elseif string.find(status_str, "Discharging") then
            charging = false
        end
        -- Для статуса "Unknown" charging останется false, что логично
    end
    print("[STATUS_BATTERY] Determined charging: ", charging)

    if capacity ~= nil then -- Эмитим сигнал только если есть данные о емкости
        print(string.format("[STATUS_BATTERY] Emitting signal: capacity=%s, charging=%s", tostring(capacity), tostring(charging)))
        awesome.emit_signal("status::battery", capacity, charging)
    else
        print("[STATUS_BATTERY] Capacity not found. Not emitting signal.")
    end
end)
