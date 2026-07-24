scope Chakrum initializer init

	globals
		public trigger Trigger = null
		private boolean isChakrum = false
	
		private constant integer ITEM_ID = 'I046'
		private constant integer RANGE = 300
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and isChakrum == false
	endfunction
	
	private function result takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "chakrum_target" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "chakrum" ) )
	    local real damage = LoadReal( udg_hash, id, StringHash( "chakrum_damage" ) )
	    local unit newTarget
	    local group correctUnits = CreateGroup()
	    local group g = CreateGroup()
        local unit u
        
        call GroupEnumUnitsInRange( g, GetUnitX( target ), GetUnitY( target ), RANGE, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) and u != target then
                call GroupAddUnit( correctUnits, u )
            endif
            call GroupRemoveUnit(g,u)
        endloop

        set newTarget = GroupPickRandomUnit( correctUnits )
        if newTarget != null then
	        set isChakrum = true
	        call UnitDamageTarget( caster, newTarget, damage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS )
	        set isChakrum = false
        endif

        call DestroyGroup( g )
        call DestroyGroup( correctUnits )
		
		set g = null
		set u = null
		set correctUnits = null
	    set caster = null
	    set target = null
	    set newTarget = null
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = AfterAttack.GetDataUnit("caster")
	    local unit target = AfterAttack.GetDataUnit("target")
	    local real damage = AfterAttack.GetDataReal("damage")
	    local integer id
	    
	    set id = InvokeTimerWithUnit( caster, "chakrum", 0.01, false, function result )
	    call SaveUnitHandle( udg_hash, id, StringHash( "chakrum_target" ), target )
	    call SaveReal( udg_hash, id, StringHash( "chakrum_damage" ), damage )
	    
	    set caster = null
	    set target = null
	endfunction

	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P3' )
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P4' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P3' )
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0P4' )
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope