library WeaponPieceDatabase initializer init requires WeaponPieceSystem

	globals
		public Event array EventUsed
		public integer EventUsed_Max = 0	
	endglobals

	private function AddEvent takes Event eventUsed returns nothing
		set EventUsed[EventUsed_Max] = eventUsed
		set EventUsed_Max = EventUsed_Max + 1
	endfunction

	private function SetEvents takes nothing returns nothing
		call AddEvent(BeforeAttack)
	endfunction

	private function SetItems takes nothing returns nothing
		call WeaponPiece.create('I0CF', Katana_Trigger, BeforeAttack, "Katana" )
		call WeaponPiece.create('I0DB', null, 0, "Blockade" )
	endfunction

	private function delay takes nothing returns nothing
		call SetItems()
		call SetEvents()
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.1, false, function delay )
	endfunction

endlibrary