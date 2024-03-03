library Ability

	public function IsUnitAbility takes unit unitToCheck, integer abilityId returns boolean
        local integer index = GetUnitUserData(unitToCheck)
        local integer heroNumber = udg_HeroNum[index]
        local integer i = 1
        
        loop
        	exitwhen i > 4
        	if abilityId == Database_Hero_Abilities[i][heroNumber] then
        		return true
        	endif
        	set i = i + 1
    	endloop
        if abilityId == udg_Ability_Uniq[index] then
        	return true
        endif
        if abilityId == udg_Ability_Spec[index] then
        	return true
        endif
        return false
    endfunction

endlibrary