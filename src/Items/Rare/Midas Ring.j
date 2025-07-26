scope MidasRing initializer init

	globals
		private constant integer ABILITY_ID = 'A0UG'
		private constant integer ITEM_ID = 'I0EE'
		
		private constant integer GOLD_LEGENARY = 100
		private constant integer GOLD_RARE = 50
		private constant integer GOLD_COMMON = 20
		private constant integer MAX_CHARGES = 3
		
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl"
		private constant integer CHARGE_KEY = StringHash( "midas_ring_charges" )
	endglobals

	private function CheckCharges takes unit caster returns boolean
		local item itemTarget = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
		local integer chargesUsed = LoadInteger(udg_hash, GetHandleId(itemTarget), CHARGE_KEY)
		set itemTarget = null
		return MAX_CHARGES - chargesUsed <= 0
	endfunction

	private function condition takes nothing returns boolean
		if GetSpellAbilityId() != ABILITY_ID then
			return false
		elseif GetItemTypeId(GetSpellTargetItem()) == ITEM_ID then
			return false
		/*elseif Corrupted_Logic(GetSpellTargetItem()) then
			return false*/
		elseif CheckCharges(GetSpellAbilityUnit()) then
			call ErrorMessage(GetOwningPlayer(GetSpellAbilityUnit()), "Not enough charges." )
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
	
	private function ChangeCharge takes unit caster returns nothing
		local item midasRing = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
		local integer id = GetHandleId(midasRing)
	    local integer chargesUsed = LoadInteger(udg_hash, id, CHARGE_KEY)
		local string newText
	
		set chargesUsed = chargesUsed + 1
	    call SaveInteger(udg_hash, id, CHARGE_KEY, chargesUsed)
	    set newText = words( caster, BlzGetItemDescription(midasRing), "|cffffffff", "|r", I2S(MAX_CHARGES - chargesUsed) )
	    call BlzSetItemExtendedTooltip( midasRing, newText )
	
		set caster = null
		set midasRing = null
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = GetSpellAbilityUnit()
	    local item itemTarget = GetSpellTargetItem()
	    local integer i = 0
	    local integer iMax = UnitInventorySize(caster)
	    local boolean found = false
	    
	
	    loop
	        exitwhen found or i >= iMax
	        if itemTarget == UnitItemInSlot( caster, i ) then
	            call AddSpecialEffectTarget( ANIMATION, caster, "origin")
	            call GoldGain( GetItemType(itemTarget), caster )
	            call RemoveItem( itemTarget )
	            set found = true
	        endif
	        set i = i + 1
	    endloop
	    
	    call ChangeCharge(caster)

	    set caster = null
	    set itemTarget = null
	endfunction
	
	//===========================================================================
	private function condition_battle_end takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action_battle_end takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local item midasRing = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
		local integer id = GetHandleId(midasRing)
		local string newText

	    call SaveInteger(udg_hash, id, CHARGE_KEY, 0)
	    set newText = words( caster, BlzGetItemDescription(midasRing), "|cffffffff", "|r", I2S(MAX_CHARGES) )
	    call BlzSetItemExtendedTooltip( midasRing, newText )
	
		set caster = null
		set midasRing = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action_battle_end, function condition_battle_end, null )
	endfunction	

endscope