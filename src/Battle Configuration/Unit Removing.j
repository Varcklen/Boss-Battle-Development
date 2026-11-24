scope UnitRemoving initializer init

	private function RemoveUnits takes unit hero returns nothing
		local player owner = GetOwningPlayer(hero)
    	local group g = CreateGroup()
	    local unit u
	    
	    call GroupEnumUnitsOfPlayer(g, owner, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            //call BJDebugMsg("Unit: " + GetUnitName(u))
            if not( IsUnitType( u, UNIT_TYPE_HERO) ) and not( IsUnitType( u, UNIT_TYPE_STRUCTURE) ) and GetUnitAbilityLevel( u, 'A1ER') == 0 then
                call RemoveUnit( u )
                //call BJDebugMsg("REMOVED")
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        set bj_livingPlayerUnitsTypeId = 'u000'
        call GroupEnumUnitsOfPlayer(g, owner, filterLivingPlayerUnitsOfTypeId)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call RemoveUnit( u )
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyGroup( g )
	    set u = null
	    set g = null
	    set owner = null
    endfunction
    
	private function FightStart takes nothing returns nothing
		call RemoveUnits(udg_FightStart_Unit )
	endfunction
	
	private function FightEnd takes nothing returns nothing
		call RemoveUnits(udg_FightEnd_Unit)
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_FightStart_Real", function FightStart, null )
		call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, null )
	endfunction

endscope