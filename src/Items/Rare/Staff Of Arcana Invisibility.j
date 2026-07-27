scope StaffOfArcanaInvisibility initializer init

	globals
		private constant integer ITEM_ID = 'I04E'
		private constant real TICK = 1
		
		private constant real DISTANCE = 400
	endglobals
	
	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	/*function KeeperECast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "kepe" ) )
	    local integer lvl = LoadInteger( udg_hash, id, StringHash( "kepelvl" ) )
	    local integer cyclA
	    local boolean l = false
	    local integer dist = 525 + 75 * lvl
	    
	    if GetUnitAbilityLevel( caster, 'A0A9') == 0 or caster == null then
	        call UnitRemoveAbility( caster, 'A0BH' )
	        call UnitRemoveAbility( caster, 'A0B5' )
	        call UnitRemoveAbility( caster, 'B09C' )
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    elseif GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then
	        set cyclA = 1
	        loop
	            exitwhen cyclA > 4
	            if DistanceBetweenUnits( caster, udg_hero[cyclA] ) < dist and caster != udg_hero[cyclA] and GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then
	                set l = true
	                set cyclA = 4
	            endif
	            set cyclA = cyclA + 1
	        endloop
	        if (caster == udg_unit[57] or caster == udg_unit[58] or not(l)) and GetUnitAbilityLevel( caster, 'A0BH') > 0 then
	            call UnitRemoveAbility( caster, 'A0BH' )
	            call UnitRemoveAbility( caster, 'A0B5' )
	            call UnitRemoveAbility( caster, 'B09C' )
	        elseif caster != udg_unit[57] and caster != udg_unit[58] and l and GetUnitAbilityLevel( caster, 'A0BH') == 0 then
	            call UnitAddAbility( caster, 'A0BH' )
	            call UnitAddAbility( caster, 'A0B5' )
	            call SetUnitAbilityLevel( caster, 'A0B5', lvl )
	            call InvisibilitySystem_LaunchEvent(caster)
	        endif
	    endif
	    
	    set caster = null
	endfunction*/
	
	private function ConditionCheck takes unit caster, unit unitCheck returns boolean
		if unitCheck == null then
			return false
		elseif caster == unitCheck then
			return false
		elseif IsUnitDead(unitCheck) then
			return false
		elseif DistanceBetweenUnits( caster, unitCheck ) > DISTANCE then
			return false
		elseif IsUnitEnemy( unitCheck, GetOwningPlayer( caster ) ) then
			return false
		elseif InvisibilitySystem_IsActive(unitCheck) then
			return false
		elseif BlzIsUnitInvulnerable(unitCheck) then
			return false
		endif
		
		return true
	endfunction
	
	private function InvisibilityCheck takes unit caster, integer id returns nothing 
		local boolean isEnabled = LoadBoolean( udg_hash, id, StringHash( "staff_of_arcana_invis_is_enabled" ) )
		local boolean isActive = false
		local unit unitCheck
		local integer i
	
		set i = 1
        loop
        	exitwhen i > 4 or isActive
            set unitCheck = udg_hero[i]
            set isActive = ConditionCheck(caster, unitCheck)
            set i = i + 1
        endloop
        
        if isActive and isEnabled == false then
            call InvisibilitySystem_Apply(caster, null, 0)
            call SaveBoolean( udg_hash, id, StringHash( "staff_of_arcana_invis_is_enabled" ), true )
        elseif isActive == false and isEnabled then
            call InvisibilitySystem_ReduceCounter(caster)
            call SaveBoolean( udg_hash, id, StringHash( "staff_of_arcana_invis_is_enabled" ), false )
        endif
	endfunction

	private function Check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "staff_of_arcana_invis_hero" ) )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "staff_of_arcana_invis" ) )
	    local boolean isEnabled
	    
	    if UnitHasItem( hero, itemUsed ) == false then
	    	set isEnabled = LoadBoolean( udg_hash, id, StringHash( "staff_of_arcana_invis_is_enabled" ) )
	    	if isEnabled then
	    		call InvisibilitySystem_ReduceCounter(hero)
	    	endif
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitAlive( hero ) then
	        call InvisibilityCheck(hero, id)
	    endif
	    
	    set itemUsed = null
	    set hero = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local unit hero = GetManipulatingUnit()
		local item itemUsed = GetManipulatedItem()
		local integer id 
	
		set id = InvokeTimerWithItem( itemUsed, "staff_of_arcana_invis", TICK, true, function Check )
		call SaveUnitHandle( udg_hash, id, StringHash( "staff_of_arcana_invis_hero" ), hero ) 
	    
	    set hero = null
	    set itemUsed = null
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing  
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope