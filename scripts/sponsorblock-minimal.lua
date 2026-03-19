-- sponsorblock_minimal.lua
--
-- This script skips sponsored segments of YouTube videos
-- using data from https://github.com/ajayyy/SponsorBlock

local opt = require 'mp.options'
local utils = require 'mp.utils'

local ON = false
local ranges = nil

local category_names = {
	["Chapter"] = "chapter",
	["Endcards/Credits"] = "outro",
	["Filler Tangent"] = "filler",
	["Highlight"] = "poi_highlight",
	["Interaction Reminder"] = "interaction",
	["Intermission/Intro Animation"] = "intro",
	["Non-Music Section"] = "music_offtopic",
	["Preview/Recap"] = "preview",
	["Sponsor"] = "sponsor",
	["Unpaid/Self Promotion"] = "selfpromo",
}

local options = {
	server = "https://sponsor.ajay.app/api/skipSegments",

	-- Categories to fetch and skip
	categories = "sponsor",

	-- Set this to "true" to use sha256HashPrefix instead of videoID
	hash = ""
}

opt.read_options(options)

local categories = {}
for str in string.gmatch(string.lower(options.categories), "([^;]+)") do
	categories[#categories + 1] = str
end

function skip_ads(name,pos)
	if pos then
		for _, i in pairs(ranges) do
			v = i.segment[2]
			if i.segment[1] <= pos and v > pos then
				--this message may sometimes be wrong
				--it only seems to be a visual thing though
				mp.osd_message(("[sponsorblock] skipping forward %ds"):format(math.floor(v-mp.get_property("time-pos"))))
				--need to do the +0.01 otherwise mpv will start spamming skip sometimes
				--example: https://www.youtube.com/watch?v=4ypMJzeNooo
				mp.set_property("time-pos",v+0.01)
				return
			end
		end
	end
end

function fetch_sponsor_segments(youtube_id)
	local args = {"curl", "-L", "-s", "-G", "--data-urlencode", ("categories=%s"):format(utils.format_json(categories))}
	local url = options.server
	if options.hash == "true" then
		local sha = mp.command_native{
			name = "subprocess",
			capture_stdout = true,
			args = {"sha256sum"},
			stdin_data = youtube_id
		}
		url = ("%s/%s"):format(url, string.sub(sha.stdout, 0, 4))
	else
		table.insert(args, "--data-urlencode")
		table.insert(args, "videoID=" .. youtube_id)
	end
	table.insert(args, url)

	local sponsors = mp.command_native{
		name = "subprocess",
		capture_stdout = true,
		playback_only = false,
		args = args
	}
	if sponsors.stdout then
		local json = utils.parse_json(sponsors.stdout)
		if type(json) == "table" then
			if options.hash == "true" then
				for _, i in pairs(json) do
					if i.videoID == youtube_id then
						return i.segments
					end
				end
			else
				return json
			end
		end
	end
end

function fetch_ranges()
	local video_path = mp.get_property("path", "")
	local video_referer = string.match(mp.get_property("http-header-fields", ""), "Referer:([^,]+)") or ""

	local urls = {
		"ytdl://youtu%.be/([%w-_]+).*",
		"ytdl://w?w?w?%.?youtube%.com/v/([%w-_]+).*",
		"https?://youtu%.be/([%w-_]+).*",
		"https?://w?w?w?%.?youtube%.com/v/([%w-_]+).*",
		"/watch.*[?&]v=([%w-_]+).*",
		"/embed/([%w-_]+).*",
		"^ytdl://([%w-_]+)$",
		"-([%w-_]+)%."
	}
	local youtube_id = nil
	local purl = mp.get_property("metadata/by-key/PURL", "")
	for i,url in ipairs(urls) do
		youtube_id = youtube_id or string.match(video_path, url) or string.match(video_referer, url) or string.match(purl, url)
		if youtube_id then break end
	end

	if youtube_id and string.len(youtube_id) >= 11 then
		youtube_id = string.sub(youtube_id, 1, 11)
		return fetch_sponsor_segments(youtube_id)
	end
end

function get_ranges_from_chapters()
	local skipped_categories = {}
	for _, category in ipairs(categories) do
		skipped_categories[category] = true
	end

	local ranges = {}

	local chapters = mp.get_property_native("chapter-list")
	local duration = mp.get_property_native("duration")
	local have_sponsorblock_chapters = false

	for i, chapter in ipairs(chapters) do
		local categories_string = string.match(chapter.title, "%[SponsorBlock%]:%s(.+)")

		if categories_string then
			have_sponsorblock_chapters = true

			for category_name in string.gmatch(categories_string, "([^,]+),?%s?") do
				local category = category_names[category_name]
				if skipped_categories[category] then
					local to = duration
					if i < #chapters then
						to = chapters[i+1].time
					end
					table.insert(ranges, {["segment"] = {chapter.time, to}, ["category"] = category})
				end
			end
		end
	end

	if not have_sponsorblock_chapters then
		return nil
	end

	return ranges
end

function file_loaded()
	ranges = get_ranges_from_chapters() or fetch_ranges()

	if ranges then
		ON = true
		mp.add_key_binding("b","sponsorblock",toggle)
		mp.observe_property("time-pos", "native", skip_ads)
	end
end

function end_file()
	if not ON then return end
	mp.unobserve_property(skip_ads)
	ranges = nil
	ON = false
end

function toggle()
	if ON then
		mp.unobserve_property(skip_ads)
		mp.osd_message("[sponsorblock] off")
		ON = false
	else
		mp.observe_property("time-pos", "native", skip_ads)
		mp.osd_message("[sponsorblock] on")
		ON = true
	end
end

mp.register_event("file-loaded", file_loaded)
mp.register_event("end-file", end_file)
