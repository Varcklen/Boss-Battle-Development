scope DemonicWarglaive initializer init

	globals
		private constant integer ITEM_ID = 'I08T'
		
		private constant integer DAMAGE = 20
	endglobals

	private function condition takes nothing returns boolean
		if udg_IsDamageSpell then
			return false
		elseif ( inv( udg_DamageEventSource, ITEM_ID ) > 0 or ( inv( udg_DamageEventSource, 'I030') > 0 and udg_Set_Weapon_Logic[GetPlayerId(GetOwningPlayer(udg_DamageEventSource)) + 1 + 100] ) ) == false then
			return false
		endif
		return true
	endfunction
	
	private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "dmwg" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "dmwgc" ) )
	
	    call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	    call FlushChildHashtable( udg_hash, id )
	
	    set target = null
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id = GetHandleId( udg_DamageEventTarget )
	    
	    if LoadTimerHandle( udg_hash, id, StringHash( "dmwg" ) ) == null then
	        call SaveTimerHandle( udg_hash, id, StringHash( "dmwg" ), CreateTimer() )
	    endif
	    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "dmwg" ) ) ) 
	    call SaveUnitHandle( udg_hash, id, StringHash( "dmwg" ), udg_DamageEventTarget )
	    call SaveUnitHandle( udg_hash, id, StringHash( "dmwgc" ), udg_DamageEventSource )
	    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( "dmwg" ) ), 0.01, false, function cast )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope