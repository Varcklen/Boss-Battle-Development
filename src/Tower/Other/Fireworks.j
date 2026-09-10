scope Fireworks initializer init
	
	globals
		private constant integer FIREWORKS_TO_CAST = 20
		private constant real TICK = 0.25
		
		private constant integer SPAWN_PER_TICK_MIN = 2
		private constant integer SPAWN_PER_TICK_MAX = 5
	endglobals
	
	private function condition takes nothing returns boolean
		return BattleEndGlobal.GetDataBoolean("is_win")
	endfunction
	
	private function Cast takes nothing returns nothing
		local effect fx
		local integer i
	    local integer iEnd
		
		set i = 1
        set iEnd = GetRandomInt(SPAWN_PER_TICK_MIN, SPAWN_PER_TICK_MAX)
        loop
            exitwhen i > iEnd
            set fx = AddSpecialEffect(udg_Database_Feerverk[GetRandomInt(1, 4)], GetRectCenterX(gg_rct_Feerverk) + GetRandomReal( -2320, 2320 ), GetRectCenterY(gg_rct_Feerverk) + GetRandomReal( -656, 656 ) )
	        call BlzSetSpecialEffectZ( fx, GetRandomReal(350,450) )
	        call DestroyEffect( fx )
            set i = i + 1
        endloop
		
		set fx = null
	endfunction
	
	private function FireworksTick takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local integer counter = LoadInteger( udg_hash, id, StringHash( "fireworks" ) ) + 1

	    if udg_fightmod[0] or counter > FIREWORKS_TO_CAST then
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call SaveInteger( udg_hash, id, StringHash( "fireworks" ), counter )
	        call Cast()
	    endif
	endfunction
	
	private function action takes nothing returns nothing
	    local timer t = CreateTimer()
	    local integer id = GetHandleId( t )
	
		call TimerStart( t, TICK, true, function FireworksTick )
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call BattleEndGlobal.AddListener(function action, function condition)

	    set udg_Database_Feerverk[1] = "Fireworksblue.mdx"
	    set udg_Database_Feerverk[2] = "Fireworksred.mdx"
	    set udg_Database_Feerverk[3] = "Fireworksgreen.mdx"
	    set udg_Database_Feerverk[4] = "Fireworkspurple.mdx"
	endfunction
	
endscope