scope CurseWildGrowth initializer init

	globals
		private trigger Trigger = null
		private trigger TriggerEnd = null
		
		private timer TimerUsed = CreateTimer()
		
		private integer GROWTH_AREA = 128
	endglobals
	
	private function check takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local effect vine = LoadEffectHandle( udg_hash, id, StringHash( "mdb27v" ) )
	    local group g = CreateGroup()
	    local group affected = CreateGroup()
	    local unit u
	
	    if not( udg_fightmod[0] ) then
	        call DestroyEffect(vine)
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call GroupEnumUnitsInRange( g, BlzGetLocalSpecialEffectX( vine ), BlzGetLocalSpecialEffectY( vine ), GROWTH_AREA, null )
	        loop
	            set u = FirstOfGroup(g)
	            exitwhen u == null
	            if IsUnitAlly(u, Player(4)) then
	                call GroupAddUnit(affected, u)
	            endif
	            call GroupRemoveUnit(g,u)
	        endloop
	    
	        if IsUnitGroupEmptyBJ(affected) == false then
	            loop
	                set u = FirstOfGroup(affected)
	                exitwhen u == null
	                set bj_lastCreatedUnit = CreateUnit( Player( PLAYER_NEUTRAL_AGGRESSIVE ), 'u000', GetUnitX( u ), GetUnitY( u ), 270 )
	                call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1)   
	                call UnitAddAbility( bj_lastCreatedUnit, 'A0LG')
	                call IssueTargetOrder( bj_lastCreatedUnit, "entanglingroots", u )
	                call GroupRemoveUnit(affected,u)
	            endloop
	            call DestroyEffect(vine)
	            call DestroyTimer( GetExpiredTimer() )
	        endif
	    endif
	    
	    call DestroyGroup( g )
	    call DestroyGroup( affected )
	    set vine = null
	    set u = null
	    set g = null
	    set affected = null
	endfunction
	
	private function activation_delay takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local effect vine = LoadEffectHandle( udg_hash, id, StringHash( "curse_vine" ) )

		call InvokeTimerWithEffect( vine, "curse_vine_check", 0.5, true, function check )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set vine = null
	endfunction
	
	private function spawn takes nothing returns nothing
	    local integer id
	    local unit hero
	    local effect vine
	
	    if not( udg_fightmod[0] ) then
	        call PauseTimer(TimerUsed)
	    else
	        set hero = DeathSystem_GetRandomAliveHero()
	        
	        if hero != null then
	            set vine = AddSpecialEffect("Abilities\\Spells\\NightElf\\EntanglingRoots\\EntanglingRootsTarget.mdl", Math_GetUnitRandomX(hero, 500), Math_GetUnitRandomY(hero, 500))
	            call BlzSetSpecialEffectColor( vine, 255, 50, 50 )
	        
	        	call InvokeTimerWithEffect( vine, "curse_vine", 2, false, function activation_delay )
	        endif
	    endif
	    
	    set hero = null
	    set vine = null
	endfunction
	
	private function action takes nothing returns nothing
		call ResumeTimer(TimerUsed)
	endfunction
	
	private function action_end takes nothing returns nothing
		call PauseTimer(TimerUsed)
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		call EnableTrigger( TriggerEnd )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
		call DisableTrigger( TriggerEnd )
		call PauseTimer(TimerUsed)
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, null )
		call DisableTrigger( Trigger )
		
		set TriggerEnd = CreateEventTrigger( "udg_FightEndGlobal_Real", function action_end, null )
		call DisableTrigger( TriggerEnd )
		
		call TimerStart( TimerUsed, 12, true, function spawn )
		call PauseTimer(TimerUsed)
	endfunction

endscope