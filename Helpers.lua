IterateGroupMembers = function(reversed, forceParty)
	local unit	= (not forceParty and IsInRaid()) and 'raid' or 'party'
	local numGroupMembers = (forceParty and GetNumSubgroupMembers()	or GetNumGroupMembers()) - (unit == "party" and 1 or 0)
	local i = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
	return function()
		local ret
		if i == 0 and unit == 'party' then
			ret = 'player'
		elseif i <= numGroupMembers and i > 0 then
			ret = unit .. i
		end
		i = i + (reversed and -1 or 1)
		return ret
	end
end