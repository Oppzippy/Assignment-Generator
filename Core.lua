AssignmentGeneratorAddon = LibStub("AceAddon-3.0"):NewAddon("AssignmentGenerator", "AceConsole-3.0")
local addon = AssignmentGeneratorAddon -- TODO: rename this

function addon:OnInitialize()
	addon:RegisterChatCommand("ag", "SlashCommand")
end

function addon:OnEnable()

end

function addon:OnDisable()

end


-- Test for now
function addon:SlashCommand(input)
	local findBuilder = self:CreateFindBuilder()
	
	findBuilder:SetDefaultRole("DAMAGER")
	findBuilder:AddNextPriority("WARLOCK")
	
	findBuilder:SetIndex(1)
	findBuilder:SetCount(5)
	
	local findObj = findBuilder:Build()
	
	local gen = self:CreateAssignmentGenerator()
	
	gen:AddText("Here are some players: ")
	gen:AddObject(findObj)
	gen:NewLine()
	gen:AddText("^^")
	
	self:Print(gen:ToString())
end