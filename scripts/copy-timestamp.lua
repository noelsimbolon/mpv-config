-- copy-timestamp.lua - copy current timestamp to clipboard (a script for mpv player)
-- copyright (c) 2023  Alex Rogers <https://github.com/linguisticmind>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

-- Video tutorial: https://youtu.be/SSL9wm2l5SQ&t=11m29s

-- version: 0.1.1

require('mp.options')

local options = {
  console_message = true,
  console_message_print_copied = true,
  osd_message = true,
  osd_message_print_copied = true,
  clipboard_command = 'pbcopy',
}

read_options(options, 'copy_timestamp')

local function copy_timestamp(arg)

  arg = arg or {}

  arg.timestamp_format = arg.timestamp_format or 'formatted'

  local function format_timestamp(t)
    local s_ms = t % 60
    local r = t - s_ms
    local h = math.floor(r / 3600)
    r = r - (h * 3600)
    local m = r / 60
    local s, ms = string.format('%.03f', s_ms):match('([^.]*).(.*)')
    return string.format('%02d:%02d:%02d.%03d', h, m, s, ms)
  end

  local result

  if arg.timestamp_format == 'formatted' then
    result = format_timestamp(mp.get_property_number("time-pos"))
  elseif arg.timestamp_format == 'raw' then
    result = string.format('%.03f', mp.get_property_number('time-pos'))
  end

  mp.commandv(
    'run', '/usr/bin/env', 'bash', '-c',
    string.format("<<<'%s' LANG=en_US.UTF-8 %s", result:gsub("'", "'\\''"), options.clipboard_command)
  )

  if options.console_message == true then
    if options.console_message_print_copied == true then
      print(string.format('Copied %s timestamp to clipboard:\n%s', arg.timestamp_format, result))
    else
      print(string.format('Copied %s timestamp to clipboard', arg.timestamp_format))
    end
  end

  if options.osd_message == true then
    if options.osd_message_print_copied == true then
      mp.osd_message(string.format('Copied %s timestamp to clipboard: %s', arg.timestamp_format, result))
    else
      mp.osd_message(string.format('Copied %s timestamp to clipboard', arg.timestamp_format))
    end
  end

end

-- keybindings are set in input.conf
mp.add_key_binding(nil, "copy-timestamp-formatted", function() copy_timestamp{ timestamp_format = 'formatted' } end)
mp.add_key_binding(nil, "copy-timestamp-raw", function() copy_timestamp{ timestamp_format = 'raw' } end)
