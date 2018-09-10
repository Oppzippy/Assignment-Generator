local addon = AssignmentGeneratorAddon
local AssignmentGenerator = {}
AssignmentGenerator.__index = AssignmentGenerator

function addon:CreateAssignmentGenerator()
	local gen = {}
	setmetatable(gen, AssignmentGenerator)
	gen.builder = {}
	return gen
end

function AssignmentGenerator:AddText(text)
	table.insert(self.builder, text)
end

function AssignmentGenerator:NewLine()
	table.insert(self.builder, "\n")
end

function AssignmentGenerator:AddObject(object)
	table.insert(self.builder, object)
end

function AssignmentGenerator:ToString()
	local stringBuilder = {}
	
	for i, object in ipairs(self.builder) do
		local t = type(object)
		if t == "string" then
			table.insert(stringBuilder, object)
		elseif t == "table" then
			table.insert(stringBuilder, self:Generate(object))
		end
	end
	
	return table.concat(stringBuilder)
end

function AssignmentGenerator:Generate(object)
	local t = object.type
	
	if t == "FIND" then
		local matches = AssignmentGenerator:FindMatches(object)
		local ret = {}
		local count = #matches
		for i = 1, count do
			local name = UnitExists(matches[i]) and UnitName(matches[i]) or matches[i]
			table.insert(ret, name)
			if i ~= count then
				table.insert(ret, ", ")
			end
		end
		
		return table.concat(ret)
	end
end

function AssignmentGenerator:MatchRoles(roles, role)
	for _,r in ipairs(roles) do
		if role == r then
			return true
		end
	end
	return false
end


-- a and b should be tables with 'priority' keys
local function CompareByPriority(a, b)
	return a.priority > b.priority
end

function AssignmentGenerator:FindMatches(object)
	local matches = {}
	
	for unit in IterateGroupMembers() do
		for i, priority in ipairs(object.priority) do
			local role = UnitGroupRolesAssigned(unit)
			local _,class = UnitClass(unit)
			if (priority.class == nil or priority.class == class)
				and AssignmentGenerator:MatchRoles(priority.roles, role) then
				table.insert(matches, {
					["unit"] = unit,
					["priority"] = i,
				})
			end
		end
	end
	
	table.sort(matches, CompareByPriority)
	
	local ret = {}
	for i = object.index, object.index + object.count - 1 do
		table.insert(ret, (matches[i] and matches[i].unit) or "nil")
	end
	
	return ret
end