library WeaponPieceSystem requires EventSystem, SetCount

	globals
		public WeaponPiece array WeaponPieces
		public integer WeaponPieces_Max = 0
		
		/*public WeaponEvent array WeaponEventUsed
		public integer WeaponEventUsed_Max = 0*/
		
		public constant integer ULTIMATE_WEAPON_ID = 'I030'
		
		public UltimateWeapon WeaponData
		
		private constant integer STRING_HASH = StringHash("ultimate_weapon")
	endglobals
	
	//==========================================================================
	public function IsItemTypeAdded takes unit hero, integer itemType returns boolean
		local item ultWeapon = GetItemOfTypeFromUnitBJ( hero, ULTIMATE_WEAPON_ID)
		local UltimateWeapon ultWeaponData
		
		if ultWeapon == null then
			return false
		endif
		
		set ultWeaponData = UltimateWeapon.GetStruct(ultWeapon)
		
		return ultWeaponData.IsExist(itemType)
	endfunction
	
	public function IsItemCanBeAddedToUltimateWeapon takes unit hero, integer itemCheck returns boolean
		local integer index = GetUnitUserData(hero)
		return udg_logic[index + 54] and WeaponType_Logic(itemCheck) and WeaponPieceSystem_IsItemTypeAdded(hero, itemCheck) == false
	endfunction
	
	
	//==========================================================================
	
	/*struct WeaponEvent
		readonly Event EventUsed
		
		readonly WeaponPiece array Pieces[20]
		readonly integer Pieces_Max = 0
		
		static method create takes Event eventUsed returns thistype
			local thistype p = thistype.allocate()
			
			set p.EventUsed = eventUsed
			
			set WeaponEventUsed[WeaponEventUsed_Max] = p
			set WeaponEventUsed_Max = WeaponEventUsed_Max + 1
			
            return p
        endmethod
        
        private method Add takes WeaponPiece piece returns nothing
        	set Pieces[Pieces_Max] = piece
        	set Pieces_Max = Pieces_Max + 1
        endmethod
        
        static method AddEvent takes Event eventUsed, WeaponPiece piece returns thistype
        	local integer i = 0
        	local integer iMax = WeaponEventUsed_Max
        	local WeaponEvent weaponEvent
        	
        	loop
        		exitwhen i >= iMax
        		set weaponEvent = WeaponEventUsed[i]
        		if weaponEvent.EventUsed == eventUsed then
        			call weaponEvent.Add(piece)
        			return weaponEvent
        		endif
        		set i = i + 1
    		endloop
    		set weaponEvent = WeaponEvent.create(eventUsed)
    		call weaponEvent.Add(piece)
    		return weaponEvent
        endmethod 
	endstruct*/
	
	struct WeaponPiece
		readonly integer ItemId
		readonly trigger TriggerUsed
		readonly Event EventUsed
		readonly string ScopeName
		readonly integer TriggerType
		
		static method create takes integer itemId, trigger triggerUsed, Event eventUsed, string scopeName, integer triggerType returns thistype
			local thistype p = thistype.allocate()
			
			set p.ItemId = itemId
			set p.TriggerUsed = triggerUsed
			set p.EventUsed = eventUsed//WeaponEvent.AddEvent(, p)
			set p.ScopeName = scopeName
			set p.TriggerType = triggerType
			
			set WeaponPieces[WeaponPieces_Max] = p
			set WeaponPieces_Max = WeaponPieces_Max + 1
			
            return p
        endmethod
	endstruct
	
	struct UltimateWeapon
		readonly WeaponPiece array Pieces[50]
		readonly integer Pieces_Max = 0
		readonly item TriggerItem
		readonly unit TriggerUnit
	
		method IsExist takes integer itemId returns boolean
			local integer i = 0
			local integer iMax = .Pieces_Max
			//local WeaponPiece piece
			
			loop
				exitwhen i >= iMax
				//set piece = WeaponPieces[i]
				if .Pieces[i].ItemId == itemId then
					return true
				endif
				set i = i + 1
			endloop
			return false
		endmethod
	
		private method Adding takes integer itemId returns nothing
			local integer i = 0
			local integer iMax = WeaponPieces_Max
			
			set WeaponData = this
			loop
				exitwhen i >= iMax
				if WeaponPieces[i].ItemId == itemId then
					set .Pieces[Pieces_Max] = WeaponPieces[i]
					set Pieces_Max = Pieces_Max + 1

					call ExecuteFunc( WeaponPieces[i].ScopeName + "_Enable" )
				endif
				set i = i + 1
			endloop
		endmethod
		
		method onDestroy takes nothing returns nothing
			local integer i = 0
			local integer iMax = .Pieces_Max
			
			//call BJDebugMsg("onDestroy")
			set WeaponData = this
			loop
				exitwhen i >= iMax
				call ExecuteFunc( .Pieces[i].ScopeName + "_Disable" )
				set i = i + 1
			endloop
		endmethod
	
		method Add takes integer itemId returns boolean
			if .IsExist(itemId) then
				return false
			endif
			call Adding(itemId)
			return true
		endmethod
		
		static method GetStruct takes item triggerItem returns thistype
			return LoadInteger(udg_hash, GetHandleId(triggerItem), STRING_HASH)
		endmethod
		
		static method create takes item triggerItem, unit triggerUnit returns thistype
			local thistype p = thistype.allocate()
			
			set p.TriggerItem = triggerItem
			set p.TriggerUnit = triggerUnit
			call SaveInteger(udg_hash, GetHandleId(triggerItem), STRING_HASH, p )
			
            return p
        endmethod

	endstruct

endlibrary