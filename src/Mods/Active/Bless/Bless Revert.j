scope BlessRevert initializer init

	globals
		private trigger Trigger = null
		
		private integer array Revent_Bonus_Reduction

    	private constant integer BONUS_COUNT = 2
    	private constant integer REDUCTION = 150
    	
    	private boolean isUsedAgain = false
	endglobals
	
	private function EnableDiscount takes nothing returns nothing
	    local integer i
	
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if udg_hero[i] != null then
	            if isUsedAgain == false then
					set Revent_Bonus_Reduction[i] = BONUS_COUNT
				endif
	            call BookOfOblivion_Change_Cost(Player(i-1), Book_Of_Oblivion_Cost[i] - REDUCTION)
	        endif
	        set i = i + 1
	    endloop
	    
	    set isUsedAgain = true
	endfunction
	
	private function DisableDiscount takes nothing returns nothing
	    local integer i
	
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if udg_hero[i] != null and Revent_Bonus_Reduction[i] > 0 then
	            call BookOfOblivion_Change_Cost(Player(i-1), Book_Of_Oblivion_Cost[i] + REDUCTION)
	        endif
	        set i = i + 1
	    endloop
	endfunction

    private function Use takes nothing returns nothing
    	local unit caster = Event_Book_Of_Oblivion_Used_Unit
        local integer index = GetUnitUserData(caster)
        local player ownPlayer = Player(index - 1)

        if index > 0 and Revent_Bonus_Reduction[index] > 0 then
            set Revent_Bonus_Reduction[index] = Revent_Bonus_Reduction[index] - 1
            if Revent_Bonus_Reduction[index] <= 0 then
                call BookOfOblivion_Change_Cost(ownPlayer, Book_Of_Oblivion_Cost[index] + REDUCTION)
            endif
        endif

		set caster = null
        set ownPlayer = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		call EnableDiscount()
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_Book_Of_Oblivion_Used_Real", function Use, null )
		call DisableTrigger( Trigger )
	endfunction

endscope