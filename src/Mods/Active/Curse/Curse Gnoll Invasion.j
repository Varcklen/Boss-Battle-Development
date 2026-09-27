scope CurseGnollInvasion initializer init

	globals
		private trigger Trigger = null
		
		private constant integer UNIT_ID = 'n05I'
		private constant integer COOLDOWN = 20
		private constant integer HASH_KEY = StringHash( "curse_gnoll_invasion" )
		private constant string SPAWN_ANIMATION = "Void Teleport Caster.mdx"
		
		private constant integer HEALTH_START = 80
		private constant integer HEALTH_LEVEL = 20
		
		private constant integer DAMAGE_START = 8
		private constant integer DAMAGE_LEVEL = 2
	endglobals
	
	private function condition takes nothing returns boolean
		return ExtraArenaGeneral_IsPvPActive() == false
	endfunction
	
	private function Spawn takes nothing returns nothing
		local unit newUnit
		local location spawnLoc = GetRandomLocInRect(udg_Boss_Rect)

		set newUnit = CreateUnitAtLoc( Player(10), UNIT_ID, spawnLoc, GetRandomDirectionDeg() )
        call DestroyEffect( AddSpecialEffectTarget(SPAWN_ANIMATION, newUnit, "origin" ) )
        
        call BlzSetUnitBaseDamage( newUnit, DAMAGE_START + (udg_Boss_LvL - 1) * DAMAGE_LEVEL, 0 ) 
        call BlzSetUnitMaxHP( newUnit, HEALTH_START + (udg_Boss_LvL - 1) * HEALTH_LEVEL )
		call SetUnitState( newUnit, UNIT_STATE_LIFE, GetUnitState( newUnit, UNIT_STATE_MAX_LIFE ) )
        
        call RemoveLocation(spawnLoc)
        set spawnLoc = null
        set newUnit = null
	endfunction
	
	private function cast takes nothing returns nothing
	    if udg_fightmod[0] == false then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	call Spawn()
	    endif
	endfunction
	
	private function action takes nothing returns nothing
    	local timer timerUsed = LoadTimerHandle( udg_hash, 1, HASH_KEY )
        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, HASH_KEY, timerUsed )
        endif
        call TimerStart( timerUsed, COOLDOWN, true, function cast )
        
        set timerUsed = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope