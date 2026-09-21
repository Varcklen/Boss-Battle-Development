scope MainBattleHeroDeath initializer init

	globals
		private trigger Trigger
		
		boolean IsDefeat = false
	endglobals
	
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
    endfunction
    
    private function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
	endfunction
	
	private function Del takes nothing returns nothing
        if not( IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) ) then
            call RemoveUnit( GetEnumUnit() )
        endif
    endfunction
    
    private function SecondChance takes nothing returns nothing
        local boolean l
        local integer j
        local integer i
        local group g = udg_Bosses
        local unit u
    
    	call Attempts_Add(-1)
        call DisplayTextToForce( bj_FORCE_ALL_PLAYERS, "You have another try!" )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if DB_Boss_id[udg_Boss_LvL - 1][udg_Boss_Random] == GetUnitTypeId( u ) then
                set i = 1
                set l = false
                loop
                    exitwhen l
                    set j = i + ( ( udg_Boss_Random - 1 ) * 10 )
                    if DB_Trigger_Boss[udg_Boss_LvL][j] != null and i <= 10 then
                        call DisableTrigger( DB_Trigger_Boss[udg_Boss_LvL][j] )
                        set i = i + 1
                    else
                        set l = true
                    endif
                endloop
            endif
            call GroupRemoveUnit(g,u)
        endloop
        call Between( BATTLE_TYPE_RESSURECTION, STATE_REST )
        
        set g = null
        set u = null
    endfunction

	private function action takes nothing returns nothing
		//call BJDebugMsg("MainBattleHeroDeath")
		call DisableTrigger( GetTriggeringTrigger() )
		if Attempts_Get() > 0 then
            call SecondChance()
        else
            call Defeat_Cast()
        endif
	endfunction
	
	private function init takes nothing returns nothing
        set Trigger = AllHeroesDied.AddListener(function action, null)
        call DisableTrigger( Trigger )
        
        /*Disable*/
        call BetweenBattles.AddListener(function Disable, null)
        call CreateEventTrigger( "Event_Victory", function Disable, null)
        call CreateEventTrigger( "Event_MainBattleWin", function Disable, null)
        
    endfunction

endscope