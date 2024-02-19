library MinionsLib

	//Checks if a minion can be affected by a buff. The Sludge (minion) from Split should not receive buffs.
	function MinionAffectCheck takes unit unitToCheck returns boolean
        
        if GetUnitTypeId(unitToCheck) == 'u00X' then
        	return false
        endif
        return true
    endfunction

endlibrary