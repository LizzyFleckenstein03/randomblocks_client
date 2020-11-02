local channel = minetest.mod_channel_join("randomblocks")

local last_pos

local function get_pointed_thing()
	local pos = minetest.camera:get_pos()
	local pos2 = vector.add(pos, vector.multiply(minetest.camera:get_look_dir(), 100))
	local ray = minetest.raycast(pos, pos2, true, true)
	return ray:next()
end

minetest.register_globalstep(function()
	local pointed_thing = get_pointed_thing()
	if not pointed_thing or pointed_thing.type ~= "node" then return end
	local pos = pointed_thing.under
	if last_pos and not vector.equals(pos, last_pos) then
		channel:send_all(minetest.pos_to_string(last_pos))
	end
	last_pos = pos
end)
