local M = {}

local profile_file_markers = {
	{ name = "angular", markers = { "angular.json" } },
	{ name = "java", markers = { "pom.xml", "build.gradle" } },
	{ name = "lua", markers = { ".luarc.json", ".luarc.jsonc", "stylua.toml", ".stylua.toml", ".config/nvim/init.lua" } },
	{ name = "python", markers = { "pyproject.toml", "requirements.txt", "setup.py" } },
	{ name = "typescript", markers = { "tsconfig.json", "package.json" } },
}

local function get_profile(cwd)
	local function find_marker(marker)
		return vim.fs.find(marker, { upward = true, path = cwd, type = "file" })[1]
	end

	for _, profile in ipairs(profile_file_markers) do
		for _, marker in ipairs(profile.markers) do
			if find_marker(marker) then
				return profile.name
			end
		end
	end

	return nil
end

function M.get_profile(cwd)
	return get_profile(cwd)
end

function M.extend_core_plugins(spec, cwd)
	local profile = get_profile(cwd)
	if profile then
		vim.list_extend(spec, { { import = "profiles." .. profile } })
	end

	return spec
end

return M
