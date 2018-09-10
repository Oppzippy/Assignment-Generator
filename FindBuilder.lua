local addon = AssignmentGeneratorAddon
local FindBuilder = {}
FindBuilder.__index = FindBuilder

FindBuilder.type = "FIND"

function addon:CreateFindBuilder()
	local builder = {}
	setmetatable(builder, FindBuilder)
	builder.priority = {}
	builder.index = 1
	self.count = 1
	return builder
end

-- If a role requirement is not specified when adding to the priority, this will be used
function FindBuilder:SetDefaultRole(role)
	self.defaultRoles = {role}
end

-- Same as above, except any role in the table is acceptable
function FindBuilder:SetDefaultRoles(roles)
	self.defaultRoles = roles
end

function FindBuilder:ClearDefaultRoles()
	self.defaultRoles = {}
end

function FindBuilder:AddDefaultRole(role)
	table.insert(self.defaultRoles, role)
end

-- Either argument can be nil to ignore it in the search
-- role can be a string for one role or a table for multiple roles
function FindBuilder:AddNextPriority(class, role)
	if role == nil then
		role = self.defaultRoles
	elseif type(role) ~= table then
		role = {role}
	end
	
	local obj = {
		["class"] = class,
		["roles"] = role,
	}
	
	table.insert(self.priority, obj)
end

-- Aka offset. Skip index-1 matches before returning one
function FindBuilder:SetIndex(index)
	self.index = index
end

-- Number of matches to find
function FindBuilder:SetCount(count)
	self.count = count
end

function FindBuilder:Build()
	return {
		["type"] = FindBuilder.type,
		["index"] = self.index,
		["count"] = self.count,
		["priority"] = self.priority,
	}
end