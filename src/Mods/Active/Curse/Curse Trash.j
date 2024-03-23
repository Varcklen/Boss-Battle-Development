scope CurseTrash initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local integer cyclA
	    local integer i = 0
	    local unit array k
	    local unit u
	    
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        set k[cyclA] = null
	        if UnitInventoryCount(udg_hero[cyclA]) < 6 and udg_hero[cyclA] != null then
	            set i = i + 1
	            set k[i] = udg_hero[cyclA]
	        endif
	        set cyclA = cyclA + 1
	    endloop
	
	    if i > 0 then
	        set u = k[GetRandomInt(1,i)]
	        if u != null then
	            call UnitAddItem(u, CreateItem('I0B5', GetUnitX(u), GetUnitY(u)))
	        endif
	    endif
	    
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        set k[cyclA] = null
	        set cyclA = cyclA + 1
	    endloop
	    
	    set u = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightEndGlobal_Real", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope