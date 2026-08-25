scope PotionShopChoose initializer init

	private function condition takes nothing returns boolean
	    return udg_fightmod[0] == false
	endfunction
	
	private function action takes nothing returns nothing
	    local player p = GetTriggerPlayer()

	    if GetUnitTypeId(GetTriggerUnit()) == 'h01T'then
	        call PotionShopUI_ShowBackdrop(p, true)
	    else
	        call PotionShopUI_ShowBackdrop(p, false)
	    endif
	    
	    set p = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer i = 0
	    local trigger trig
	    set trig = CreateTrigger()
	    loop
	        exitwhen i > 3
	        call TriggerRegisterPlayerSelectionEventBJ( trig, Player(i), true )
	        set i = i + 1
	    endloop
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    set trig = null
	endfunction

endscope