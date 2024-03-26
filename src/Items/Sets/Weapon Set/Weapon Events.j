library WeaponEvents initializer init requires WeaponPieceDatabase

	private function condition takes nothing returns boolean
		return inv( Event.Current.TriggerUnit, WeaponPieceSystem_ULTIMATE_WEAPON_ID ) > 0
	endfunction
	
	private function action takes nothing returns nothing
		local item itemUsed = GetItemOfTypeFromUnitBJ( Event.Current.TriggerUnit, WeaponPieceSystem_ULTIMATE_WEAPON_ID)
		local UltimateWeapon ultWeapon = UltimateWeapon.GetStruct(itemUsed)
		local integer i = 0
		local integer iMax = ultWeapon.Pieces_Max
		local Event eventUsed = Event.Current
		local WeaponPiece piece
		
		loop
			exitwhen i >= iMax
			set piece = ultWeapon.Pieces[i]
			if piece.EventUsed == eventUsed then
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