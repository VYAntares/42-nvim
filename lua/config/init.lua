--[[ Config loader. ]]--

local config = ... .. "."

-- Load builtin configs
require(config .. "builtin")

-- Load extra configs
require(config .. "extras")

-- Load custom configs
require(config .. "custom")
