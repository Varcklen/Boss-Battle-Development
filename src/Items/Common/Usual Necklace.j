scope UsualNecklace initializer init

	globals
		private constant integer ITEM_ID = 'I07A'
		private constant integer ALT_ITEM_ID = 'I07Q'
		
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and IsUnitAlive(UnitDied.TriggerUnit) 
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
		call SwapItem(UnitDied.GetDataUnit("killer"), ITEM_ID, ALT_ITEM_ID)
	endfunction
	
	private function actionAlt takes nothing returns nothing
		call SwapItem(UnitDied.GetDataUnit("killer"), ALT_ITEM_ID, ITEM_ID)
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
	    call RegisterDuplicatableItemTypeCustom( ALT_ITEM_ID, UnitDied, function actionAlt, function condition, "killer" )
	endfunction
	
endscope