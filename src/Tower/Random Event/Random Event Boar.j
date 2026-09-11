scope RandomEventBoar initializer init

	globals
		private boolean IsActive = false
		
		private constant integer PEACEFUL_BOAR = 'n044'
		private constant integer BATTLE_BOAR = 'n045'
		private constant string SPAWN_ANIMATION = "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return ExtraArenaGeneral_IsPvPActive() == false and IsActive
	endfunction
	
	private function BoarSpawn takes nothing returns nothing
		local location unitSpawn = GetRandomLocInRect(udg_Boss_Rect)
		local unit newUnit
	
	    set newUnit = CreateUnitAtLoc( Player(4), BATTLE_BOAR, unitSpawn, GetRandomReal( 0, 360 ) )
	    call DestroyEffect( AddSpecialEffectLoc( SPAWN_ANIMATION, unitSpawn ) )

	    call FlushChildHashtable( udg_hash, GetHandleId( GetExpiredTimer() ) )
	    
	    call RemoveLocation(unitSpawn)
	    set unitSpawn = null
	    set newUnit = null
	endfunction
	
	private function action takes nothing returns nothing
		set IsActive = false
        call TimerStart( CreateTimer(), 1, false, function BoarSpawn )
	endfunction
	
	//===========================================================================
	private function OnDeath_Condition takes nothing returns boolean
		return GetUnitTypeId(GetDyingUnit()) == PEACEFUL_BOAR
	endfunction
	
	private function OnDeath takes nothing returns nothing
		set IsActive = true
        call StartSound(gg_snd_QuestLog)
	endfunction

    //===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function OnDeath, function OnDeath_Condition )
	endfunction

endscope