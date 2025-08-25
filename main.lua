local filepath = SMODS.current_mod.path

local assets = NFS.getDirectoryItems(filepath .. "lua")
for _, asset in ipairs(assets) do
	print("CLOWNFISH - Loading " .. asset)
	local load, err = SMODS.load_file("lua/" .. asset)
	if err then
		error(err) 
	end
	load()
end