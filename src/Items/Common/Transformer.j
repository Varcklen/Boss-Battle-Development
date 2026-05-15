scope Transformer initializer init

	globals
		private constant integer ITEM_ID = 'IZ00'
		private constant integer SPELL_ID = 'A1HO'
		private constant integer CHARGES_AMOUNT = 2
		
		private constant integer STRING_HASH = StringHash("transformer")
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == SPELL_ID
	endfunction
	
	private function ChangeItem takes unit caster, item itemTarget, item itemUsed, integer chargesLeft returns nothing
		local string newDescription
		local integer id = GetHandleId(itemUsed)
		
    	call RemoveItem( itemTarget )
        call AddSpecialEffectTarget( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", caster, "origin")
        call ItemRandomizerSet(caster, 1)
        
        set chargesLeft = chargesLeft + 1
		call SaveInteger(udg_hash, id, STRING_HASH, chargesLeft)
        set newDescription = words( caster, BlzGetItemExtendedTooltip(itemUsed), "|cffffffff", "|r", I2S( CHARGES_AMOUNT - chargesLeft ) )
		call BlzSetItemExtendedTooltip( itemUsed, newDescription )
		
		set itemUsed = null
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = GetSpellAbilityUnit()
		local item itemTarget = GetSpellTargetItem()
    	local integer i
    	local item itemUsed = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
    	local integer id = GetHandleId(itemUsed)
    	local integer chargesLeft = LoadInteger(udg_hash, id, STRING_HASH)

		if chargesLeft >= CHARGES_AMOUNT then
			call ErrorMessage(GetOwningPlayer(caster), GetItemName(itemUsed) + ": No charges left.")
			return
		endif

		if itemTarget == null or GetItemTypeId(itemTarget) == ITEM_ID or GetItemType(itemTarget) == ITEM_TYPE_POWERUP then
			return
		endif
		
		call eyest( caster )

		set i = 0
	    loop
	        exitwhen i > 5
	        if itemTarget == UnitItemInSlot( caster, i ) then
	            call ChangeItem(caster, itemTarget, itemUsed, chargesLeft)
	            exitwhen true
	        endif
	        set i = i + 1
	    endloop

		set itemTarget = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope