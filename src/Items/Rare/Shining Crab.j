scope ShiningCrab initializer init

	globals
		private constant integer ITEM_ID = 'I0HG'
		
		private constant integer SPELL_POWER_INCREASE = 2
		private constant integer STRING_HASH = StringHash( "shining_crab" )
	endglobals

	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function End takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local integer bonusGain = LoadInteger( udg_hash, id, STRING_HASH )
	    
	    call textst( "|cff00ccee+" + I2S(bonusGain) + "% Spell Power", caster, 64, GetRandomReal( 45, 135 ), 8, 1.5 )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed
		local integer bonusGain = SetCount_GetPieces( caster, SET_CRYSTAL) * SPELL_POWER_INCREASE
		local integer playerIndex = GetPlayerId(GetOwningPlayer(caster)) + 1
		local integer saveIndex = playerIndex + 268
		
		call spdst( caster, bonusGain)
		set udg_Data[saveIndex] = udg_Data[saveIndex] + bonusGain
		
		set timerUsed = CreateTimer()
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call SaveInteger( udg_hash, id, STRING_HASH, bonusGain )
        call TimerStart( timerUsed, 1, false, function End )
		
    	set caster = null
    	set timerUsed = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope