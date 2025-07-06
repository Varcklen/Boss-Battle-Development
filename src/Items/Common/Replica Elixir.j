scope ReplicaElixir initializer init

	globals
		private constant integer ITEM_ID = 'I0HF'
		
		private constant integer HEAL_RESTORE = 300
		private constant integer MANA_RESTORE = 100
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"
		
		private constant integer STRING_HASH = StringHash( "replica_elixir" )
	endglobals

	//OnBaatleStart
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function End takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    
	    call UnitAddItem( caster, CreateItem(ITEM_ID, GetUnitX(caster), GetUnitY(caster) ) )
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
        call TimerStart( timerUsed, 0.5, false, function End )
	    
	    set caster = null
	endfunction
	
	//Cast
	private function condition_cast takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction

	private function action_cast takes nothing returns nothing
		local unit caster = GetManipulatingUnit()
		
	    call healst( caster, null, HEAL_RESTORE )
	    call manast( caster, null, MANA_RESTORE )
	    call spectimeunit( caster, ANIMATION, "origin", 2 )
	    call stazisst( caster, GetManipulatedItem() )

	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action_cast, function condition_cast )
	endfunction
	
endscope