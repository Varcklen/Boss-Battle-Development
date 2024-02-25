library MinionsLib

	//Checks if a minion can be affected by a buff. The Sludge (minion) from Split should not receive buffs.
	function MinionAffectCheck takes unit unitToCheck returns boolean
        
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

endlibrary