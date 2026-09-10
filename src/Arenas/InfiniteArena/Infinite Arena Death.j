scope InfiniteArenaDeath initializer init

	globals
		private trigger Trigger
	endglobals
	
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
	endfunction
	
	private function action takes nothing returns nothing
		//call BJDebugMsg("InfiniteArenaDeath")
		call DisableTrigger( GetTriggeringTrigger() )
        call Between( BATTLE_TYPE_INFINITE_ARENA, STATE_REST )
	endfunction
	
	private function init takes nothing returns nothing
        set Trigger = AllHeroesDied.AddListener(function action, null)
        call DisableTrigger( Trigger )
        
        /*Disable*/
        call BetweenBattles.AddListener(function Disable, null)
    endfunction

endscope