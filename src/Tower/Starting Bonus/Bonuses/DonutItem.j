scope DonutItem initializer init

	globals
		private integer ITEM_ID = 'IV08'
		
		private integer BASE_STAT_INCREASE = 4
		private integer INCREMENTAL_STAT_INCREASE = 4
		
		private string PARTICLE = "Abilities\\Spells\\Items\\RitualDagger\\RitualDaggerTarget.mdl"
		
		private integer HASH_KEY = StringHash( "donut_item" )
	endglobals

	private function condition_battle_end takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action_battle_end takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local item usedItem = GetItemOfTypeFromUnitBJ( hero, ITEM_ID)
		local integer id = GetHandleId(usedItem)
		local integer statIncrease = LoadInteger( udg_hash, id, HASH_KEY )
		local string newDescription
		
		set statIncrease = statIncrease + INCREMENTAL_STAT_INCREASE
		
		call SaveInteger( udg_hash, id, HASH_KEY, statIncrease )
		set newDescription = words( hero, BlzGetItemExtendedTooltip(usedItem), "|cffffffff", "|r", I2S( statIncrease + BASE_STAT_INCREASE ) )
		call BlzSetItemExtendedTooltip( usedItem, newDescription )
		
		set usedItem = null
	    set hero = null
	endfunction
	
	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local item usedItem = GetManipulatedItem()
		local integer id = GetHandleId(usedItem)
		local integer statIncrease = LoadInteger( udg_hash, id, HASH_KEY ) + BASE_STAT_INCREASE
	
	    call statst( hero, statIncrease, statIncrease, statIncrease, 0, true )
	    call DestroyEffect( AddSpecialEffect( PARTICLE, GetUnitX( hero ), GetUnitY( hero ) ) )
	    call stazisst( hero, usedItem )
	    
	    set usedItem = null
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action_battle_end, function condition_battle_end, null )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction

endscope