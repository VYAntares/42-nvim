--[[ Built-ins config loader. ]]--

local config = ... .. "."

-- Load Telescope Settings.
require(config .. "_telescope")

-- Load LSP Settings.
require(config .. "_lsp")

-- Load Autocompletion Settings.
require(config .. "_cmp")

-- Load File Tree Settings.
require(config .. "_neo-tree")

-- Load Lua Line Extensions
require(config .. "_lualine")
