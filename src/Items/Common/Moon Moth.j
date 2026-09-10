scope MoonMoth initializer init
	
	globals
		private constant integer ITEM_ID = 'I07E'
		
		private constant integer DURATION = 30
		private constant integer STRING_HASH = StringHash( "moon_moth" )
		private constant string ANIMATION = "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function CastEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    
	    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( caster ), GetUnitY( caster ) ) )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed
		
		call InvisibilitySystem_Apply(caster, null, DURATION)
		
		set timerUsed = CreateTimer()
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call TimerStart( timerUsed, 1, false, function CastEnd )
		
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope