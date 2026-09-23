scope EarthTotem initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer HEAL_AMOUNT = 70
		private constant real TICK = 1
		private constant string RAY_TYPE = "DRAL"
		private constant string HEAL_ANIMATION = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"
	endglobals
	
	private function HealCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "water_totem_boss" ) )
	    local unit totem = LoadUnitHandle( udg_hash, id, StringHash( "water_totem" ) )
	    local real healAmount

	    if IsUnitDead(totem) or IsUnitDead(boss) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	    	set healAmount = HEAL_AMOUNT * SpellPower_GetBossSpellPower()
	        call SetUnitState( boss, UNIT_STATE_LIFE, GetUnitState( boss, UNIT_STATE_LIFE ) + healAmount )
            call textst( "|c0000C800+" + R2SI( healAmount ), boss, 64, GetRandomReal( 45, 135 ), 8, 1 )
            call spectimeunit( boss, HEAL_ANIMATION, "origin", 2 )
	    endif

	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit totem = Woodo1_TriggerTotem
		local unit boss = Woodo1_TriggerBoss
		local integer id
		
		call Lightning_CreateFollowingRay( RAY_TYPE, totem, boss, true )
		
		set id = InvokeTimerWithUnit( totem, "water_totem", TICK, true, function HealCast )
		call SaveUnitHandle( udg_hash, id, StringHash( "water_totem_boss" ), boss )
		
		set totem = null
		set boss = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateTrigger(  )
    	call TriggerAddAction( Trigger, function action )
	endfunction
	
endscope