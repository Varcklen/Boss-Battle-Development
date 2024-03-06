scope Tassadar initializer init

    globals
        private constant integer ID_ITEM = 'I04O'

		private constant integer COST_REDUCTION = -15
		
		private constant integer STRING_HASH = StringHash("tassadar_value")
    endglobals

    private function Check_Conditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == ID_ITEM
    endfunction
    
    private function SetBonus takes unit owner, integer setValue returns nothing
    	local integer uniqueId = UniquesLib_Get(owner)
    	local integer id = GetHandleId(owner)
    	local integer currentBonus = LoadInteger(udg_hash, id, STRING_HASH)
    	local integer valueToAdd = setValue * COST_REDUCTION
    	local ability unique = BlzGetUnitAbility( owner, uniqueId )
    	local integer baseValue
    	
    	if currentBonus == 0 or setValue == 0 then
    		set baseValue = BlzGetAbilityIntegerLevelField( unique, ABILITY_ILF_MANA_COST, 0)
    		call SaveInteger(udg_hash, id, StringHash("tassadar_base_value"), baseValue)
		else
			set baseValue = LoadInteger(udg_hash, id, StringHash("tassadar_base_value"))
    	endif
    	
    	if valueToAdd != 0 then 
	    	set currentBonus = currentBonus + valueToAdd
	    	call SaveInteger(udg_hash, id, STRING_HASH, currentBonus)
    	endif
    	
    	/*call BJDebugMsg("currentBonus: " + I2S(currentBonus))
    	call BJDebugMsg("currentBonus: " + I2S(baseValue))
    	call BJDebugMsg("sum: " + I2S( IMaxBJ(0, baseValue + currentBonus)))*/
    	call BlzSetAbilityIntegerLevelFieldBJ( unique, ABILITY_ILF_MANA_COST, 0, IMaxBJ(0, baseValue + currentBonus) )
    
    	set unique = null
    	set owner = null
    endfunction

    private function Add takes nothing returns nothing
        call SetBonus(GetManipulatingUnit(), 1)
    endfunction
    
    private function Remove takes nothing returns nothing
        call SetBonus(GetManipulatingUnit(), -1)
    endfunction
    
    private function OnUniqueChange_Conditions takes nothing returns boolean
        return inv(Event_UniqueChanged_Unit, ID_ITEM) > 0
    endfunction
    
    private function OnUniqueChange takes nothing returns nothing
        call SetBonus(Event_UniqueChanged_Unit, 0)
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function Check_Conditions ) )
	    call TriggerAddAction( trig, function Add )
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )
	    call TriggerAddCondition( trig, Condition( function Check_Conditions ) )
	    call TriggerAddAction( trig, function Remove )
	    
	    call CreateEventTrigger( "Event_UniqueChanged", function OnUniqueChange, function OnUniqueChange_Conditions )
    endfunction

endscope