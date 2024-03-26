library MinionsLib

	//Checks if a minion can be affected by a buff. The Sludge (minion) from Split should not receive buffs.
	function IsPermaBuffAffected takes unit unitToCheck returns boolean
        
        if GetUnitAbilityLevel( unitToCheck, 'A1EN') > 0 then
        	return false
        endif
        return true
    endfunction
    
    //Checks whether a unit can be affected by boss effects directed against minions.
    function IsMinionImmune takes unit unitToCheck returns boolean
        
        if GetUnitAbilityLevel( unitToCheck, 'A1EG') > 0 then
        	return true
        endif
        return false
    endfunction
    
    function IsMinion takes unit unitToCheck returns boolean
    	if IsUnitType( unitToCheck, UNIT_TYPE_HERO) then
    		return false
		elseif IsUnitType( unitToCheck, UNIT_TYPE_ANCIENT) then
    		return false
		endif
        return true
    endfunction


endlibrary