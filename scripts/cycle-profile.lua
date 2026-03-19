--[[
    script to cycle profiles with a keybind, accomplished through script messages
    available at: https://github.com/CogentRedTester/mpv-scripts

    syntax:
        script-message cycle-profiles profile1 profile2 "profile 3"

    You must put the name of the profile in quotes if it contains special characters like spaces.

    The script will print the profile description to the screen when switching,
    if there is no profile description, then it just prints the name.
    You can disable osd messages with the `cycle_profiles-osd` script opt,
    and you can force whether or not to show the osd messages by using:
        script-message cycle-profiles/osd profile1 profile2
        script-message cycle-profiles/no_osd profile1 profile2

    If the `profile-restore` option is set on a profile, then cycling
    off that profile will run the restore operation.
    Cycling to an empty profile ("") will restore the previous profile
    without enabling a new one, so to toggle a profile you can do:

        script-message cycle-profiles profile1 ""
    
    Note that the script will not detect if a profile has already
    been applied in any other manner.
]]--

local o = {
    -- print messages to the osd when cycling profiles
    osd = true,

    -- prefer the profile-desc string over the profile name
    -- when printing osd messages
    prefer_description = true,

    -- the format string to use for the osd message
    -- see: https://www.lua.org/manual/5.1/manual.html#pdf-string.format
    osd_format_string = '%s',

    -- the string to show when applying an empty profile ("")
    osd_empty_string = 'restoring profiles'
}

local mp = require 'mp'
local msg = require 'mp.msg'
local opts = require 'mp.options'

opts.read_options(o, 'cycle_profiles')

--table of all available profiles and options
local profile_map = {}

--keeps track of current profile for every unique cycle
local iterators = {}

local function setup_profile_list()
    local profile_list = mp.get_property_native('profile-list', {})

    for _, profile in ipairs(profile_list) do
        profile_map[profile.name] = profile
    end
end

local function main(osd, ...)
    local profiles = {...}
    local key = table.concat(profiles, ';')
    local prev_iterator = iterators[key]

    if iterators[key] == nil then
        msg.debug('unknown cycle, creating iterator')
        iterators[key] = 1
    else
        iterators[key] = iterators[key] + 1
        if iterators[key] > #profiles then iterators[key] = 1 end
    end

    --converts the string into an array of profile names
    msg.verbose('cycling', key)
    msg.verbose('number of profiles:', #profiles)

    local prev_profile = profiles[prev_iterator]
    local new_profile = profiles[iterators[key]]

    -- restore the previous profile
    if prev_iterator and profile_map[prev_profile] and profile_map[prev_profile]['profile-restore'] then
        msg.info('restoring profile', prev_profile)
        mp.commandv('apply-profile', prev_profile, 'restore')
    end

    -- abort if the new profile is an empty string
    if new_profile == '' then
        if osd then mp.osd_message(o.osd_empty_string) end
        return
    end

    -- abort if the new profile is unknown
    if not profile_map[new_profile] then
        msg.error('tried to enable unknown profile "'..new_profile..'"')
        mp.osd_message('unknown profile: '..new_profile)
        return
    end

    --sends the command to apply the profile
    msg.info('applying profile', new_profile)
    mp.commandv('apply-profile', new_profile)

    --prints the profile description to the OSD
    local desc = o.prefer_description and profile_map[new_profile]['profile-desc'] or new_profile
    if osd then mp.osd_message(o.osd_format_string:format(desc)) end
end

setup_profile_list()
mp.register_script_message('cycle-profiles', function(...) main(o.osd, ...) end)
mp.register_script_message('cycle-profiles/osd', function(...) main(true, ...) end)
mp.register_script_message('cycle-profiles/no_osd', function(...) main(false, ...) end)
