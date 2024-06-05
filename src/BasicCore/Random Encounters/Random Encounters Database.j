library RandomEncounterDatabase initializer init

	globals
		private RandomEncounter array AllRandomEncounters
		private integer AllRandomEncounters_Max = 0
		
		private RandomEncounter array LowLevelRandomEncounters
		private integer LowLevelRandomEncounters_Max = 0
	endglobals

	struct RandomEncounter
		readonly player Owner
		readonly integer TypeId
		private trigger ExtraTrigger
		
		static method create takes integer typeId, integer ownerType, boolean isLateLevels, code extraTrigger returns thistype
            local thistype p = thistype.allocate()
            
            set p.Owner = Player(ownerType)
            set p.TypeId = typeId
            set p.ExtraTrigger = CreateTrigger()
            call TriggerAddAction( p.ExtraTrigger, extraTrigger )
            
            if isLateLevels == false then
	            set LowLevelRandomEncounters_Max = LowLevelRandomEncounters_Max + 1
	            set LowLevelRandomEncounters[LowLevelRandomEncounters_Max] = p
            endif
            
        	set AllRandomEncounters_Max = AllRandomEncounters_Max + 1
        	set AllRandomEncounters[AllRandomEncounters_Max] = p

            return p
        endmethod
        
        method UseTrigger takes nothing returns nothing
			if .ExtraTrigger != null then
        		call TriggerExecute(.ExtraTrigger)
        	endif
		endmethod
	endstruct 
	
	public function GetRandom takes boolean isLateLevels returns RandomEncounter
		local integer rand
		if isLateLevels then
			set rand = GetRandomInt(1, AllRandomEncounters_Max)
			//call BJDebugMsg("isLateLevels")
			//call BJDebugMsg("rand: " + I2S(rand))
			return AllRandomEncounters[rand]
		endif
		set rand = GetRandomInt(1, LowLevelRandomEncounters_Max)
		//call BJDebugMsg("rand: " + I2S(rand))
		return LowLevelRandomEncounters[rand]
	endfunction

	private function AddCorrupted takes nothing returns nothing
		local integer i
		
		set i = 1
        loop 
            exitwhen i > 3
            call AddItemToStock( bj_lastCreatedUnit, udg_DB_Item_Destroyed[GetRandomInt(1, udg_Database_NumberItems[29] )], 1, 1 )
            set i = i + 1
        endloop
	endfunction
	
	private function AddSheep takes nothing returns nothing
		local integer i
		
		set i = 1
        loop 
            exitwhen i > 3
            call AddItemToStock( bj_lastCreatedUnit, udg_BD_Item_Sheep[GetRandomInt(1, udg_Database_NumberItems[30] )], 1, 1 )
            set i = i + 1
        endloop
	endfunction
	
	private function AddGifts takes nothing returns nothing
		call AddItemToStock( bj_lastCreatedUnit, 'I05N', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I05G', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I0CL', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I06Y', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I03Q', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I04V', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I04N', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I04M', 1, 1 )
        call AddItemToStock( bj_lastCreatedUnit, 'I03X', 1, 1 )
	endfunction
	
	private function Check takes nothing returns nothing
		if udg_Endgame > 1 then
			call RemoveUnit(bj_lastCreatedUnit)
		endif
	endfunction

	private function init takes nothing returns nothing
        call RandomEncounter.create('n043', PLAYER_NEUTRAL_PASSIVE, false, null)
        call RandomEncounter.create('h01J', PLAYER_NEUTRAL_PASSIVE, false, null)
        call RandomEncounter.create('n042', PLAYER_NEUTRAL_PASSIVE, false, function AddCorrupted)
        call RandomEncounter.create('o013', PLAYER_NEUTRAL_PASSIVE, false, null)
        call RandomEncounter.create('n044', PLAYER_NEUTRAL_AGGRESSIVE, true, null)
        call RandomEncounter.create('n04G', PLAYER_NEUTRAL_PASSIVE, true, function AddGifts)
        call RandomEncounter.create('n01K', PLAYER_NEUTRAL_PASSIVE, false, function Check)
        call RandomEncounter.create('h022', PLAYER_NEUTRAL_AGGRESSIVE, false, null)
        call RandomEncounter.create('n04S', PLAYER_NEUTRAL_PASSIVE, true, function AddSheep)
        call RandomEncounter.create('n058', PLAYER_NEUTRAL_PASSIVE, false, null)
        call RandomEncounter.create('n05B', PLAYER_NEUTRAL_PASSIVE, true, null)
        call RandomEncounter.create('n031', PLAYER_NEUTRAL_PASSIVE, false, null)
    endfunction

endlibrary