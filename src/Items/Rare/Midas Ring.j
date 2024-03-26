scope MidasRing initializer init

	globals
		private constant integer ABILITY_ID = 'A0UG'
		private constant integer ITEM_ID = 'I0EE'
		
		private constant integer GOLD_LEGENARY = 90
		private constant integer GOLD_RARE = 60
		private constant integer GOLD_COMMON = 30
		
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl"
	endglobals

	private function condition takes nothing returns boolean
		if GetSpellAbilityId() != ABILITY_ID then
			return false
		elseif GetItemTypeId(GetSpellTargetItem()) == ITEM_ID then
			return false
		elseif Corrupted_Logic(GetSpellTargetItem()) then
			return false
		endif
	    return true
	endfunction
	
	private function GoldGain takes itemtype itemType, unit caster returns nothing
		if itemType == ITEM_TYPE_ARTIFACT then
            call moneyst( caster, GOLD_LEGENARY )
        elseif itemType == ITEM_TYPE_CAMPAIGN then
            call moneyst( caster, GOLD_RARE )
        elseif itemType == ITEM_TYPE_PERMANENT then
            call moneyst( caster, GOLD_COMMON )
        endif
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = GetSpellAbilityUnit()
	    local item itemTarget = GetSpellTargetItem()
	    local integer i = 0
	    local integer iMax = UnitInventorySize(caster)
	
	    loop
	        exitwhen i >= iMax
	        if itemTarget == UnitItemInSlot( caster, i ) then
	            call AddSpecialEffectTarget( ANIMATION, caster, "origin")
	            call GoldGain( GetItemType(itemTarget), caster )
	            call RemoveItem( itemTarget )
	            set i = iMax
	        endif
	        set i = i + 1
	    endloop
	    
	    set caster = null
	    set itemTarget = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope