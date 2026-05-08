scope MeatOnAStickItem initializer init

	globals
		private integer ITEM_ID = 'IV35'
		private integer RARITY = 1
		
		private string PARTICLE = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local integer itemType = DB_Items[RARITY][GetRandomInt( 1, udg_Database_NumberItems[RARITY] )]
		local item newItem
		
		if ItemManipulation_IsInventoryFull(hero) == false then
			set newItem = CreateItem(itemType, GetUnitX(hero), GetUnitY(hero))
			call UnitAddItem(hero, newItem)
			call DestroyEffect( AddSpecialEffect( PARTICLE, GetUnitX(hero), GetUnitY(hero) ) )
		endif
		
		set newItem = null
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction

endscope