scope DemonicWarglaive initializer init

	globals
		private constant integer ITEM_ID = 'I08T'
		
		private constant integer DAMAGE = 20
		
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false
	endfunction
	
	private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "dmwg" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "dmwgc" ) )
	
	    call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	    call FlushChildHashtable( udg_hash, id )
	
	    set target = null
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
		local unit target = AfterAttack.GetDataUnit("target")
	    local integer id = GetHandleId( target )
	    
	    call SaveTimerHandle( udg_hash, id, StringHash( "dmwg" ), CreateTimer() )
	    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "dmwg" ) ) ) 
	    call SaveUnitHandle( udg_hash, id, StringHash( "dmwg" ), target )
	    call SaveUnitHandle( udg_hash, id, StringHash( "dmwgc" ), caster )
	    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "dmwg" ) ), 0.01, false, function cast )
	    
	    set caster = null
	    set target = null
	endfunction
	
	public function Enable takes nothing returns nothing
		/*call BJDebugMsg("Enable")
		call BJDebugMsg("Item: " + GetItemName(WeaponPieceSystem_WeaponData.TriggerItem))
		call BJDebugMsg("Unit: " + GetUnitName(WeaponPieceSystem_WeaponData.TriggerUnit))*/
		call spdst( WeaponPieceSystem_WeaponData.TriggerUnit, 10 )
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A18J' )
		
		/*if BlzGetItemAbility( WeaponPieceSystem_WeaponData.TriggerItem, 'A18J' ) != null then
			call BJDebugMsg("Ability works")
		endif*/
    endfunction
    
    public function Disable takes nothing returns nothing
    	/*call BJDebugMsg("Disable")
		call BJDebugMsg("Item: " + GetItemName(WeaponPieceSystem_WeaponData.TriggerItem))
		call BJDebugMsg("Unit: " + GetUnitName(WeaponPieceSystem_WeaponData.TriggerUnit))*/
		call spdst( WeaponPieceSystem_WeaponData.TriggerUnit, -10 )
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A18J' )
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope