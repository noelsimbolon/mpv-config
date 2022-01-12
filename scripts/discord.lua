msg = require("mp.msg")
opts = require("mp.options")
utils = require("mp.utils")

options = {
    key = "D",
    active = true,
    client_id = "737663962677510245",
    binary_path = "",
    socket_path = "/tmp/mpvsocket",
    use_static_socket_path = true,
    autohide_threshold = 0
}
opts.read_options(options, "discord")

if options.binary_path == "" then
    msg.fatal("Missing binary path in config file.")
    os.exit(1)
end
if not utils.file_info(options.binary_path) then
    msg.fatal("The specified binary path does not exist.")
    os.exit(1)
end

version = "1.6.0"
msg.info(("mpv-discord v%s by tnychn"):format(version))

socket_path = options.socket_path
if not options.use_static_socket_path then
    pid = utils.getpid()
    filename = ("mpv-discord-%s"):format(pid)
    if socket_path == "" then
        socket_path = "/tmp/" -- default
    end
    socket_path = utils.join_path(socket_path, filename)
elseif socket_path == "" then
    msg.fatal("Missing socket path in config file.")
    os.exit(1)
end
msg.info(("(mpv-ipc): %s"):format(socket_path))
mp.set_property("input-ipc-server", socket_path)

cmd = nil

function start()
    if cmd == nil then
        cmd = mp.command_native_async({
            name = "subprocess",
            playback_only = false,
            args = {
                options.binary_path,
                socket_path,
                options.client_id
            }
        }, function() end)
        msg.info("launched subprocess")
        mp.osd_message("Discord Rich Presence: Started")
    end
end

function stop()
    mp.abort_async_command(cmd)
    cmd = nil
    msg.info("aborted subprocess")
    mp.osd_message("Discord Rich Presence: Stopped")
end

if options.active then
    mp.register_event("file-loaded", start)
end

mp.add_key_binding(options.key, "toggle-discord", function()
    if cmd ~= nil then stop()
    else start() end
end)

mp.register_event("shutdown", function()
    if cmd ~= nil then stop() end
    if not options.use_static_socket_path then
        os.remove(socket_path)
    end
end)

if options.autohide_threshold > 0 then
    local timer = nil
    local t = options.autohide_threshold
    mp.observe_property("pause", "bool", function(_, value)
        if value == true then
            timer = mp.add_timeout(t, function()
                if cmd ~= nil then stop() end
            end)
        else
            if timer ~= nil then
                timer:kill()
                timer = nil
            end
            if options.active and cmd == nil then start() end
        end
    end)
end
