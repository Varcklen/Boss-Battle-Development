scope OverlordArenaDeath initializer init

	globals
		private trigger Trigger
		private trigger LastBossKilled
	endglobals
	
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
        call EnableTrigger( LastBossKilled )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
		call DisableTrigger( LastBossKilled )
	endfunction
	
	private function EndBattle takes nothing returns nothing
		//call BJDebugMsg("OverlordArenaDeath")
        call Disable()
        call Between( "end_AL" )
    endfunction
	
	private function action takes nothing returns nothing
		call DisableTrigger( GetTriggeringTrigger() )
        call EndBattle()
	endfunction
	
	private function IsLastBossKilled takes nothing returns boolean
        if udg_fightmod[4] == false then
            return false
        elseif GetUnitTypeId(GetDyingUnit()) == 'n00F' then
            return true
        elseif GetUnitTypeId(GetDyingUnit()) == 'o006' then
            return true
        endif
        return false
    endfunction
    
    private function BossKilled takes nothing returns nothing
        call EndBattle()
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
        set Trigger = AllHeroesDied.AddListener(function action, null)
        call DisableTrigger( Trigger )
        
        set LastBossKilled = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function BossKilled, function IsLastBossKilled )
        
        /*Disable*/
        call BetweenBattles.AddListener(function Disable, null)
    endfunction

endscope