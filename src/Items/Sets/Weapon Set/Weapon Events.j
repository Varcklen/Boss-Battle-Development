library WeaponEvents initializer init requires WeaponPieceDatabase

	globals
		private item UsedItem = null
		private integer UsedType = 0
	endglobals
	
	private function FindItem takes unit u, integer typeCheck returns boolean
        local integer i = 0
        local integer cyclA = 0
        local item it

		if u == null then
			return false
		endif
		
        loop
            exitwhen cyclA > 5
            set it = UnitItemInSlot( u, cyclA )
            if GetItemTypeId( it ) == WeaponPieceSystem_ULTIMATE_WEAPON_ID then
                set UsedItem = it
                set UsedType = typeCheck
                set it = null
                return true
            endif
            set cyclA = cyclA + 1
        endloop
        
        set it = null
        return false
    endfunction
    
	private function condition takes nothing returns boolean
		return FindItem(Event.Current.TriggerUnit, WeaponPieceDatabase_TRIGGER_TYPE_TRIGGER_UNIT) or FindItem(Event.Current.TargetUnit, WeaponPieceDatabase_TRIGGER_TYPE_TARGET_UNIT)
	endfunction
	
	private function action takes nothing returns nothing
		local UltimateWeapon ultWeapon = UltimateWeapon.GetStruct(UsedItem)
		local integer eventType = UsedType
		local integer i = 0
		local integer iMax = ultWeapon.Pieces_Max
		local Event eventUsed = Event.Current
		local WeaponPiece piece
		
		loop
			exitwhen i >= iMax
			set piece = ultWeapon.Pieces[i]
			if piece.EventUsed == eventUsed and piece.TriggerType == eventType then
				call ConditionalTriggerExecute(piece.TriggerUsed)
			endif
			set i = i + 1
		endloop
	endfunction

	private function delay takes nothing returns nothing
		local integer i
		local integer iMax
		local Event eventUsed
		
		set i = 0
		set iMax = WeaponPieceDatabase_EventUsed_Max
		loop
			exitwhen i >= iMax
			set eventUsed = WeaponPieceDatabase_EventUsed[i]
			call eventUsed.AddListener( function action, function condition)
			set i = i + 1
		endloop
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function delay )
	endfunction

endlibrary