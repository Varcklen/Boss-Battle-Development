scope Fedor4 initializer init

	globals
		private constant integer ID_BOSS = 'h00B'
		private constant integer HEALTH_CHECK = 100
		
		private constant integer COOLDOWN = 15
		
		private constant integer ATTACK_BOOST = 10

		public trigger Trigger = null
	endglobals
	
	private function timer_cast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_fedor_4" ) )

        if IsUnitDead(boss) or udg_fightmod[0] == false then 
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitHasAbility( boss, 'Avul' ) == false and BlzIsUnitInvulnerable(boss) == false and IsUnitInTransport(boss, Fedor2_Train) == false then
	    	call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl", GetUnitX( boss ), GetUnitY( boss ) ) )
	    	call BlzSetUnitBaseDamage( boss, BlzGetUnitBaseDamage(boss, 0) + ATTACK_BOOST, 0 )
	    endif
        
        set boss = null
    endfunction

    private function action takes nothing returns nothing
        local unit boss = udg_DamageEventTarget
        
        call InvokeTimerWithUnit( boss, "boss_fedor_4", bosscast(COOLDOWN), true, function timer_cast )
        call DisableTrigger( GetTriggeringTrigger() )
        
        set boss = null
    endfunction

	private function condition takes nothing returns boolean
        return GetUnitTypeId(udg_DamageEventTarget) == ID_BOSS and GetUnitLifePercent(udg_DamageEventTarget) <= HEALTH_CHECK
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
        call DisableTrigger( Trigger )
    endfunction

endscope