scope HexTotem initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer COOLDOWN = 4
		private constant integer HEX_DURATION = 2
	endglobals
	
	private function HexCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit totem = LoadUnitHandle( udg_hash, id, StringHash( "bswdmt" ) )
	    local unit target
	
	    if IsUnitDead( totem ) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set target = DeathSystem_GetRandomAliveHero()
	    	if target != null then
		        call UnitPoly( totem, target, 'n02M', HEX_DURATION )
		        call Lightning_CreateLightning( "AFOD", GetUnitX(totem), GetUnitY(totem), GetUnitFlyHeight(totem) + 50, GetUnitX(target), GetUnitY(target), GetUnitFlyHeight(target) + 50, 0.5 )
	        endif
	    endif
	    
	    set totem = null
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit totem = Woodo1_TriggerTotem

		call InvokeTimerWithUnit( totem, "bswdmt", COOLDOWN, true, function HexCast )
		
		set totem = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateTrigger(  )
    	call TriggerAddAction( Trigger, function action )
	endfunction
	
endscope