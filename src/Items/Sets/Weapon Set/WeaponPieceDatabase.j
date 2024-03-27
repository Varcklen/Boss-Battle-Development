library WeaponPieceDatabase initializer init requires WeaponPieceSystem

	globals
		public Event array EventUsed
		public integer EventUsed_Max = 0	
		
		public integer TRIGGER_TYPE_NULL = 0
		public integer TRIGGER_TYPE_TRIGGER_UNIT = 1
		public integer TRIGGER_TYPE_TARGET_UNIT = 2
	endglobals

	private function AddEvent takes Event eventUsed returns nothing
		set EventUsed[EventUsed_Max] = eventUsed
		set EventUsed_Max = EventUsed_Max + 1
	endfunction

	private function SetEvents takes nothing returns nothing
		call AddEvent(BeforeAttack)
		call AddEvent(AfterAttack)
	endfunction

	private function SetItems takes nothing returns nothing
		call WeaponPiece.create('I0CF', Katana_Trigger, BeforeAttack, "Katana", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I0DB', null, 0, "Blockade", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I04T', LogoshShield_Trigger, AfterAttack, "LogoshShield", TRIGGER_TYPE_TARGET_UNIT )
		call WeaponPiece.create('I02P', AncientSword_Trigger, AfterAttack, "AncientSword", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I08T', DemonicWarglaive_Trigger, AfterAttack, "DemonicWarglaive", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I00W', null, 0, "SwordOfPower", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I0AV', null, 0, "AggressiveShield", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I0D4', Armadillo_Trigger, BeforeAttack, "Armadillo", TRIGGER_TYPE_TARGET_UNIT )
	endfunction

	private function delay takes nothing returns nothing
		call SetItems()
		call SetEvents()
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.1, false, function delay )
	endfunction

endlibrary