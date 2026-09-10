library AlchemyOnly requires SetCount, ItemManipulation

	private function CheckItem takes item itemCheck returns boolean
		if itemCheck == null then
			return false
		endif
		if AlchemyLogic(itemCheck) == false and ItemManipulation_IsArtifact(itemCheck) then
			return true
		endif
		return false
	endfunction

	function AlchemyOnly takes unit caster returns boolean
	    local integer i
	    local item it
	
		set i = 0
	    loop
	        exitwhen i > 5
	        set it = UnitItemInSlot(caster, i) 
	        if CheckItem(it) then
	            return false
	        endif
	        set i = i + 1
	    endloop
	    return true
	endfunction

endlibrary