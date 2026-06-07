scope EvilNecklace initializer init

	globals
		private constant integer ITEM_ID = 'I07Q'
		private constant integer NEW_FORM_ID = 'I07A'
		private constant integer KILLS_TO_PURIFY = 5
		
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl"
		private constant integer HASH_KEY = StringHash("evil_necklace")
	endglobals

	private function condition takes nothing returns boolean
		return combat(UnitDied.GetDataUnit("killer"), false, 0) and udg_fightmod[3] == false and IsUnitAlive(UnitDied.TriggerUnit) and IsUnitEnemy( UnitDied.GetDataUnit("killer"), GetOwningPlayer( UnitDied.GetDataUnit("unit_died") ) )
	endfunction

	private function SwapItem takes unit caster, integer oldItemId, integer newItemId returns nothing
		local item oldItem = GetItemOfTypeFromUnitBJ( caster, oldItemId)
		local item newItem
		
		call RemoveItem( oldItem )
        set newItem = CreateItem( newItemId, GetUnitX(caster), GetUnitY(caster))
        call UnitAddItemSwapped( newItem, caster )
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
        
        set oldItem = null
        set newItem = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer id = GetHandleId(caster)
		local integer counter = LoadInteger(udg_hash, id, HASH_KEY ) + 1
		local item itemUsed 
		local string text
	
		if counter >= KILLS_TO_PURIFY then
			call SwapItem( caster, ITEM_ID, NEW_FORM_ID)
			set counter = 0
		endif
		set itemUsed = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
		if itemUsed != null then
			set text = I2S(counter) + "/" + I2S(KILLS_TO_PURIFY)
			call textst( "|c00ffffff " + text, caster, 64, GetRandomReal( 45, 135 ), 8, 1.5 )
			call BlzSetItemExtendedTooltip( itemUsed, words( caster, BlzGetItemDescription(itemUsed), "|cFF959697(", ")|r", text ) )
		endif
		call SaveInteger(udg_hash, id, HASH_KEY, counter )
		
		set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
	endfunction
	
endscope