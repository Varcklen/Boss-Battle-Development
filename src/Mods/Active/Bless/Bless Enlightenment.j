scope BlessEnlightenment initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit target = GroupPickRandomUnit(udg_heroinfo)

        call statst( target, 1, 1, 1, 0, false )
        call textst( "|c00ffffff +1 stats|r", target, 64, GetRandomReal( 0, 360 ), 10, 1.5 )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightEndGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope