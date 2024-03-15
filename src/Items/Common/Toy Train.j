scope ToyTrain initializer init

	globals
		private constant integer ITEM_ID = 'I06L'
		
		private constant integer STRENGH_INCREASE = 2
		private constant integer STRING_HASH = StringHash( "toy_train" )
	endglobals

	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function TrainEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    
	    call textst( "|c00FF0000+" + I2S(STRENGH_INCREASE) + " Strength", caster, 64, GetRandomReal( 45, 135 ), 8, 1.5 )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		local timer timerUsed
		
        call statst( caster, STRENGH_INCREASE, 0, 0, 56, true )
        
		set timerUsed = CreateTimer()
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, STRING_HASH, caster )
        call TimerStart( timerUsed, 1, false, function TrainEnd )
		
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition)
	endfunction

endscope