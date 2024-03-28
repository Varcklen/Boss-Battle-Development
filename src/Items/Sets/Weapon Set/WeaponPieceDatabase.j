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
		call WeaponPiece.create('I025', BattleHalberd_Trigger, BeforeAttack, "BattleHalberd", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I0H8', null, 0, "BoStaff", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I02O', BrassKnuckles_Trigger, AfterAttack, "BrassKnuckles", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I046', null, 0, "Chakrum", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I0GA', GoatDragonClaw_Trigger, AfterAttack, "GoatDragonClaw", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I04W', HeavyAx_Trigger, BeforeAttack, "HeavyAx", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I079', null, 0, "HookHands", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I05Z', null, 0, "KryptoniteKnife", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I04Y', LongBow_Trigger, AfterAttack, "LongBow", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I09F', OgreStaff_Trigger, AfterAttack, "OgreStaff", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I02E', null, 0, "OgreClub", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I07N', null, 0, "Scimitar", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I0DX', SerratedBlade_Trigger, AfterAttack, "SerratedBlade", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I00X', null, 0, "SpellbraikerShield", TRIGGER_TYPE_NULL )
		call WeaponPiece.create('I09T', SpikedShield_Trigger, AfterAttack, "SpikedShield", TRIGGER_TYPE_TARGET_UNIT )
		call WeaponPiece.create('I08U', null, 0, "CrystalBarrier", TRIGGER_TYPE_NULL ) 
		call WeaponPiece.create('I0CP', DesperadoHatchet_Trigger, BeforeAttack, "DesperadoHatchet", TRIGGER_TYPE_TRIGGER_UNIT )
		call WeaponPiece.create('I04S', TreeShield_Trigger, AfterAttack, "TreeShield", TRIGGER_TYPE_TARGET_UNIT )
		call WeaponPiece.create('I03Z', MiracleWall_Trigger, AfterAttack, "MiracleWall", TRIGGER_TYPE_TARGET_UNIT )
	endfunction

	private function delay takes nothing returns nothing
		call SetItems()
		call SetEvents()
	endfunction

	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.1, false, function delay )
	endfunction

endlibrary