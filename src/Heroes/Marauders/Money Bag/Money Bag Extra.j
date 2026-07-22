scope MoneyBagExtra initializer init
	
	globals
		private constant integer ABILITY_ID = 'A1IQ'
		
		private constant integer MONEY_BAG_Q_X_DEVIATION = -150
	    private constant integer MONEY_BAG_Q_Y_DEVIATION = 150
	    
	    private constant integer MONEY_BAG_Q_DAMAGE_PER_LEVEL = 50
	    private constant integer MONEY_BAG_Q_DAMAGE_FIRST_LEVEL_BONUS = 100
	    
	    private constant real MONEY_BAG_Q_AOE = 400
	    
	    private constant string ANIMATION = "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
	endfunction
	
	private function Check takes unit caster, unit target, integer id returns boolean
	    local boolean isWork = true
	    local integer pattern = LoadInteger(udg_hash, id, StringHash( "mbgqp" ) )
	    local unit correctTarget = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mbgqtt" ) )
	    
	    if IsUnitEnemy( target, GetOwningPlayer( caster ) ) then
	        set isWork = false
	    elseif pattern != udg_Pattern then
	        set isWork = false
	    elseif caster == target then
	        set isWork = false
	    elseif correctTarget != target then
	        set isWork = false
	    elseif IsUnitDead(caster) then
	        set isWork = false
	    elseif IsUnitDead(target) then
	        set isWork = false
	    elseif GetUnitAbilityLevel(caster, 'Avul') > 0 then//Invul
	        set isWork = false
	    elseif GetUnitAbilityLevel(target, 'A17U') == 0 then// Invul from ability
	        set isWork = false
	    elseif GetUnitAbilityLevel(target, 'A16J') > 0 then//MaidenQ
	        set isWork = false
	    endif
	    
	    set caster = null
	    set target = null
	    set correctTarget = null
	    return isWork
	endfunction
	
	private function SetPosition takes unit caster, unit target, lightning ray returns nothing
		local real x = GetUnitX( caster ) + MONEY_BAG_Q_X_DEVIATION
	    local real y = GetUnitY( caster ) + MONEY_BAG_Q_Y_DEVIATION
	
        call SetUnitX(target,x)
        call SetUnitY(target,y)
        call MoveLightningUnits( ray, caster, target )
	endfunction
	
	private function MoneyBagQMove takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "mbgq" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "mbgqt" ) )
		local lightning ray = LoadLightningHandle( udg_hash, id, StringHash( "mbgql" ) )
	
	    if Check(caster, target, id) then
	        call SetPosition(caster, target, ray)
	    else
	        call SetUnitPathing( target, true )
	        call UnitRemoveAbility( target, 'A17U' )
	    	call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mbgqtt" ), caster )
	    	call DestroyLightning( ray )
	    	if not( RectContainsUnit( udg_Boss_Rect, target) ) and udg_combatlogic[GetPlayerId(GetOwningPlayer( target )) + 1] then
	        	call SetUnitPositionLoc( target, GetRectCenter( udg_Boss_Rect ) )
	    	endif
			call FlushChildHashtable( udg_hash, id )
			call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set caster = null
	    set target = null
	    set ray = null
	endfunction
	
	private function MoneyBagQStart takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "money_bag_extra_prep_caster" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "money_bag_extra_prep" ) )
	    local lightning l
	    local integer id1
	
		call SetUnitPathing( target, false )
		call UnitAddAbility( target, 'A17U' )
	
		set l = AddLightningEx("SPLK", true, GetUnitX(caster), GetUnitY(caster), GetUnitFlyHeight(caster) , GetUnitX(target), GetUnitY(target), GetUnitFlyHeight(target))
	
		set id1 = GetHandleId( target )
		if LoadTimerHandle( udg_hash, id1, StringHash( "mbgq" ) ) == null  then
			call SaveTimerHandle( udg_hash, id1, StringHash( "mbgq" ), CreateTimer() )
		endif
		set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "mbgq" ) ) ) 
		call SaveUnitHandle( udg_hash, id1, StringHash( "mbgq" ), caster )
		call SaveUnitHandle( udg_hash, id1, StringHash( "mbgqt" ), target )
		call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mbgqtt" ), target )
		call SaveLightningHandle( udg_hash, id1, StringHash( "mbgql" ), l )
	    call SaveInteger(udg_hash, id1, StringHash( "mbgqp" ), udg_Pattern)
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "mbgq" ) ), 0.02, true, function MoneyBagQMove )
	
		call DestroyTimer( GetExpiredTimer() )
	
		set caster = null
		set target = null
	    set l = null
	endfunction
	
	private function Use takes unit caster, unit target returns nothing
		local integer id 
		local unit currentBindedUnit
	    local boolean isTargetNotOldTarget
	
		set currentBindedUnit = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mbgqtt" ) )
		set isTargetNotOldTarget = currentBindedUnit != target
		call UnitRemoveAbility( currentBindedUnit, 'A17U' )
	    call dummyspawn( caster, 1, 0, 0, 0 )
		call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mbgqtt" ), bj_lastCreatedUnit )
	    if currentBindedUnit != null then
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( currentBindedUnit ), StringHash( "mbgq" ) ), 0.01, false, function MoneyBagQMove )
	    endif
	    
		if isTargetNotOldTarget and caster != target and IsUnitAlly( target, GetOwningPlayer( caster ) ) and target != null and IsUnitType( target, UNIT_TYPE_HERO) then
			call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "chest") )
			
	        set id = InvokeTimerWithUnit( target, "money_bag_extra_prep", 0.01, false, function MoneyBagQStart )
	        call SaveUnitHandle( udg_hash, id, StringHash( "money_bag_extra_prep_caster" ), caster )
		endif  
		
		set currentBindedUnit = null
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit target

	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", RT_HERO, RT_NOT_CASTER, RT_VULNERABLE )
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif
	
		call Use(caster, target)
		
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction
	
endscope