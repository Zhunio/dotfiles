local M = {}

local function push_unique(list, items)
	for _, item in ipairs(items or {}) do
		if not vim.tbl_contains(list, item) then
			table.insert(list, item)
		end
	end
end

local function get_profiles_from_environment()
	local profiles = {}
	local pattern = "([^,]+)"

	for item in string.gmatch(vim.env.NVIM_PROFILES or "", pattern) do
		local profile = vim.trim(item)
		if profile ~= "" then
			table.insert(profiles, profile)
		end
	end

	return profiles
end

local active_profile_name = "core"

local function set_active_profile(name)
	active_profile_name = name or "core"
	vim.g.nvim_active_profile = active_profile_name
end

local profile_file_markers = {
	{ name = "angular", markers = { "angular.json" } },
	{ name = "java", markers = { "pom.xml", "build.gradle" } },
	{ name = "python", markers = { "pyproject.toml", "requirements.txt", "setup.py" } },
	{ name = "typescript", markers = { "tsconfig.json", "package.json" } },
}

local function detect_profile_from_cwd(cwd)
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

function M.get_active_profiles()
	local env_profiles = get_profiles_from_environment()
	if #env_profiles > 0 then
		set_active_profile(env_profiles[1])
		return env_profiles
	end

	local cwd = vim.fn.getcwd()
	local detected = detect_profile_from_cwd(cwd)
	if detected then
		set_active_profile(detected)
		return { detected }
	end

	set_active_profile("core")
	return {}
end

function M.get_profile(name)
	return require("profiles." .. name)
end

function M.get_plugin_spec()
	local specs = {}

	for _, profile_name in ipairs(M.get_active_profiles()) do
		local profile = M.get_profile(profile_name)
		push_unique(specs, profile)
	end

	return specs
end

function M.get_profile_label()
	return active_profile_name
end

return M
