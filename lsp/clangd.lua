function OpenHeaderFile()
	local filename = vim.fn.expand("%:t") -- Get the current file name
	local filepath = vim.fn.expand("%:p:h") -- Get the current file path
	local headername = filename:gsub("%.cpp$", ".h") -- Replace .cpp with .h

	if headername ~= filename then
		vim.cmd("set splitright")
		vim.cmd("vsplit " .. filepath .. "/../include" .. "/" .. headername)
	else
		print("Not a .cpp file or corresponding .h file doesn't exist")
	end
end

function OpenUnrealHeaderFile()
	local filename = vim.fn.expand("%:t") -- Get the current file name
	local filepath = vim.fn.expand("%:p:h") -- Get the current file path
	local headername = filename:gsub("%.cpp$", ".h") -- Replace .cpp with .h

	if headername ~= filename then
		vim.cmd("set splitright")
		vim.cmd("vsplit " .. filepath .. "/../Public/" .. "/" .. headername)
	else
		print("Not a .cpp file or corresponding .h file doesn't exist")
	end
end

local cfg = {
	on_attach = function(client)
		client.server_capabilities.signatureHelpProvider = true
		vim.keymap.set("n", "gh", [[:lua OpenHeaderFile()<CR>]], { noremap = true, silent = true })
		vim.keymap.set("n", "gp", [[:lua OpenUnrealHeaderFile()<CR>]], { noremap = true, silent = true })
	end,
	filetypes = { "c", "cpp", "h", "hpp" },
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--query-driver=**/clang++,**/clang++.exe,**/g++,**/g++.exe,**/x86_64-w64-mingw32-g++.exe,**/clang- cl.exe,**/cl.exe",
		-- "--background-index", --index every file in workspaces
		"--clang-tidy", -- additional linting and static analysis
		"--completion-style=detailed", -- detailed completion suggestions
	},
	-- cmd_env = {
	-- 	PATH = "C:/llvm-mingw/bin;" .. vim.env.PATH,
	-- },
	root_markers = { { ".clangd", ".clang-format" }, ".git" },
	-- root_markers = function()
	-- 	return vim.fn.getcwd()
	-- end,
	init_options = {
		fallbackFlags = { "-std=c++23" },
	},
}
return cfg
