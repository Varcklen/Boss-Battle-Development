scope QuestChoose initializer init

	globals
		private boolean array IsEnabled[4]
	endglobals

	private function condition takes nothing returns boolean
	    return udg_fightmod[0] == false
	endfunction
	
	private function Interaction takes player user, integer playerIndex returns nothing
		
		if udg_QuestLimit[playerIndex + 1] then
            call DisplayTimedTextToPlayer( user, 0, 0, 5, "You've already accepted the quest. You can't take another one.")
            return
        endif
        
        if udg_Boss_LvL == 1 then
			call DisplayTimedTextToPlayer( user, 0, 0, 5, "The Quartermaster is busy now. Return after the battle.")
            return
		endif
        
        if GetLocalPlayer() == user then
            call BlzFrameSetVisible( modesback, false )
            call BlzFrameSetVisible( quartback, true )
        endif
	endfunction
	
	private function action takes nothing returns nothing
	    local player p = GetTriggerPlayer()
	    local integer playerIndex = GetPlayerId( p )
	
	    if GetUnitTypeId(GetTriggerUnit()) == 'h00P' and IsEnabled[playerIndex] == false then
	        set IsEnabled[playerIndex] = true
	        call Interaction(p, playerIndex)
	    elseif IsEnabled[playerIndex] then
	    	set IsEnabled[playerIndex] = false
	        if GetLocalPlayer() == p then
	            call BlzFrameSetVisible( quartback, false )
	        endif
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
	        set IsEnabled[i] = false
	        set i = i + 1
	    endloop
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    set trig = null
	endfunction

endscope