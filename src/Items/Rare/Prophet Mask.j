scope ProphetMask initializer init

	globals
		private constant integer ITEM_ID = 'I07C'
		private constant string ANIMATION_SPAWN = "Blood Explosion.mdx"
	endglobals
	
	private function condition takes nothing returns boolean
		//call BJDebugMsg("caster: " + GetUnitName( UnitDied.GetDataUnit("killer") ) )
		return udg_fightmod[3] == false and combat( UnitDied.GetDataUnit("killer"), false, 0 ) and ItemManipulation_IsInventoryFull( UnitDied.GetDataUnit("killer") ) == false and IsUnitEnemy(UnitDied.GetDataUnit("unit_died"), GetOwningPlayer(UnitDied.GetDataUnit("killer")))
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer itemType
		local item itemCreated

		call DestroyEffect( AddSpecialEffect( ANIMATION_SPAWN, GetUnitX( caster ), GetUnitY( caster ) ) )
	        	
	    set itemType = DB_SetItems[SET_BLOOD][GetRandomInt( 1, udg_DB_SetItems_Num[SET_BLOOD] ) ]
        set itemCreated = CreateItem( itemType, GetUnitX(caster), GetUnitY(caster) )
        call UnitAddItemSwapped( itemCreated, caster )

		set caster = null
		set itemCreated = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
		//call CreateEventTrigger("Event_AfterHeal_Real", function action, function condition )
	endfunction

endscope