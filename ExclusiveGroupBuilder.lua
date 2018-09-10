local ExclusiveGroupBuilder = {}

ExclusiveGroupBuilder.type = "EXCLUSIVE_GROUP"

function addon:CreateExclusiveGroupBuilder()
	local builder = {}
	setmetatable(builder, ExclusiveGroupBuilder)
	builder.priority = {}
	builder.index = 1
	self.count = 1
end
