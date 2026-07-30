scope RunestoneZot initializer init

	globals
		private constant integer ITEM_ID = 'I09W'
		private constant integer GOLD_LOSE = 75
		private constant string ANIMATION = "Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return UnitHasItemOfTypeBJ( AnyHeroDied.TriggerUnit, ITEM_ID ) and udg_fightmod[3] == false and combat( AnyHeroDied.TriggerUnit, false, 0 ) and udg_logic[CorrectPlayer(AnyHeroDied.TriggerUnit) + 26] == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyHeroDied.GetDataUnit("caster")
		local player owner = GetOwningPlayer( caster )

		call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( caster ), GetUnitY( caster ) ) )
    	call SetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD) - GOLD_LOSE ) )
		
		set caster = null
		set owner = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyHeroDied, function action, function condition, "caster" )
	endfunction
	
endscope