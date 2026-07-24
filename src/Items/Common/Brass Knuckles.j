scope BrassKnuckles initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I02O'
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and luckylogic( AfterAttack.TriggerUnit, 10, 1, 100 ) and ItemManipulation_IsInventoryFull(AfterAttack.TriggerUnit) == false and ExtraArenaGeneral_IsPvPActive() == false and combat( AfterAttack.TriggerUnit, false, 0 )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = AfterAttack.GetDataUnit("caster")
	    local item newPot
	    local integer itemType
	    
	    set itemType = udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])]
	    set newPot = CreateItem( itemType, GetUnitX(caster), GetUnitY(caster))
    	call UnitAddItemSwapped( newPot, caster )
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
	
	    set caster = null
	    set newPot = null
	endfunction
	
	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0QX' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0QX' )
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope