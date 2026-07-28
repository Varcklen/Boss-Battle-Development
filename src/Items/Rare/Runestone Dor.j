scope RunestoneDor initializer init

	globals
		private constant integer ITEM_ID = 'I02G'
		
		private constant integer DAMAGE = 500
		private constant integer STRING_HASH = StringHash( "runestone_dor" )
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false and udg_logic[GetPlayerId( BattleStart.GetDataPlayer("owner") ) + 1 + 26] == false
	endfunction

	private function End takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    
	    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( caster ), GetUnitY( caster ) ) )
	    call UnitDamageTarget( caster, caster, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed

		set timerUsed = CreateTimer()
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call TimerStart( timerUsed, 1, false, function End )
		
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope