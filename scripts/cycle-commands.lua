--[=====[
    script to cycle commands with a keybind, accomplished through script messages
    available at: https://github.com/CogentRedTester/mpv-scripts

    syntax:
        script-message cycle-commands "command1" "command2" "command3"

    The syntax of each command is identical to the standard input.conf syntax, but each command must be within
    a pair of double quotes.

    Commands with mutiword arguments require you to send double quotes just like normal command syntax, however,
    you will need to escape the quotes with a backslash so that they are sent as part of the string.
    Semicolons also work exactly like they do normally, so you can easily send multiple commands each cycle.

    Here is an example of a standard input.conf entry:

        script-message cycle-commands "show-text one 1000 ; print-text two" "show-text \"three four\""

    This would, on keypress one, print 'one' to the OSD for 1 second and 'two' to the console,
    and on keypress two 'three four' would be printed to the OSD.
    Notice how the quotation marks around 'three four' are escaped using backslashes.
    All other syntax details should be exactly the same as usual input commands.

    There are no limits to the number of commands, and the script message can be used as often as one wants,
    the script stores the current iteration for each unique cycle command, so there should be no overlap
    unless one binds the exact same command string (including spacing)
]=====]--


local msg = require 'mp.msg'

--keeps track of commands and iterators
local cmd = {}

--[=====[

    the script stores the command in an array of command strings
    the table is in the format:
        table[full string].table[cycle]
        table[full string].iterator

]=====]--
function main(...)
    --to identify the specific cycle we'll concatenate all the strings together to use
    --as our table key
    local str = ""
    for _,v in ipairs({...}) do
        str = str .. v .. " | "
    end
    msg.debug('recieved: ' .. str)

    --if there is nothing saved for the current string, then runs through the process of storing the commands in the table
    if cmd[str] == nil then
        msg.verbose('unknown cycle, creating command table')
        cmd[str] = {}
        cmd[str].iterator = 0
        msg.verbose('parsing table for: ' .. str)
        cmd[str].table = {...}
    end

    --moves the iterator forward
    cmd[str].iterator = cmd[str].iterator + 1
    if cmd[str].iterator > #cmd[str].table then
        msg.verbose('reached end of cycle, wrapping back to start')
        cmd[str].iterator = 1
    end

    local i = cmd[str].iterator

    --runs each command in the cycle
    --mp.command shouldrun the commands exactly as if they were entered in
    --input.conf. This should provide universal support for all input.conf command syntax
    msg.verbose('sending commands: ' .. cmd[str].table[i])
    mp.command(cmd[str].table[i])
end

mp.register_script_message('cycle-commands', main)
