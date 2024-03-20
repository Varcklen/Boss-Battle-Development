scope WitchLove initializer init

	globals
		private constant integer ITEM_ID = 'I0E7'
		
		private constant integer UNIT_SPAWN = 'h021'
		
		private constant integer STRING_HASH = StringHash( "witch_love" )
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
	endglobals
	
	private function WitchLoveEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local real x = GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect))
	    local real y = GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))
	    
		call CreateUnit( GetOwningPlayer( caster ), UNIT_SPAWN, x, y, 270 )
	    call DestroyEffect( AddSpecialEffect( ANIMATION, x, y ) )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed
		
		set timerUsed = CreateTimer()
		set id = GetHandleId(timerUsed )

        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call TimerStart( timerUsed, 0.5, false, function WitchLoveEnd )

    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null)
	endfunction

endscope