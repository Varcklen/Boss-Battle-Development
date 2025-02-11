scope SniperP initializer init

    globals
		trigger trg_SniperP = null
		trigger trg_SniperPD = null
		trigger trg_SniperPAR = null
		trigger trg_SniperPAA = null
		private constant integer LEARN_ID = 'A0LA'
		private constant integer HANDLER_ID = 'A18P'
		private constant integer ASPD_ID = 'A18Q'
		private constant integer DMG_ID = 'A18R'
		private constant integer BUFF_ID = 'B031'
		
		private constant integer ALT_HANDLER_ID = 'A1SP'
		private constant integer ALT_ASPD_ID = 'A1SA'
		private constant integer ALT_DMG_ID = 'A1SD'
		private constant integer ALT_BUFF_ID = 'B0SP'
    endglobals
    
function Trig_SniperP_Conditions takes nothing returns boolean
    return GetLearnedSkill() == LEARN_ID
endfunction

function SniperPCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "snp" ) )
    local integer lvl = GetUnitAbilityLevel( u, LEARN_ID )
    
    if Aspects_IsHeroAspectActive( u, ASPECT_02 ) then
	    call UnitAddAbility( u, ALT_HANDLER_ID )
	    call UnitAddAbility( u, ALT_ASPD_ID )
	    call UnitAddAbility( u, ALT_DMG_ID )
	    call SetUnitAbilityLevel( u, ALT_ASPD_ID, lvl )
	    call SetUnitAbilityLevel( u, ALT_DMG_ID, lvl )
    else
	    call UnitAddAbility( u, HANDLER_ID )
	    call UnitAddAbility( u, ASPD_ID )
	    call UnitAddAbility( u, DMG_ID )
	    call SetUnitAbilityLevel( u, ASPD_ID, lvl )
	    call SetUnitAbilityLevel( u, DMG_ID, lvl )
	endif
    if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", u, "origin" ) )
    endif
    
    set u = null
endfunction

function Trig_SniperP_Actions takes nothing returns nothing
	local unit u = GetLearningUnit()
	local integer id = GetHandleId( u )
    
    call UnitRemoveAbility( u, HANDLER_ID )
    call UnitRemoveAbility( u, ASPD_ID ) 
    call UnitRemoveAbility( u, DMG_ID ) 
    call UnitRemoveAbility( u, BUFF_ID ) 
    call UnitRemoveAbility( u, ALT_HANDLER_ID )
    call UnitRemoveAbility( u, ALT_ASPD_ID ) 
    call UnitRemoveAbility( u, ALT_DMG_ID ) 
    call UnitRemoveAbility( u, ALT_BUFF_ID ) 
    
    if LoadTimerHandle( udg_hash, id, StringHash( "snp" ) ) == null then
        call SaveTimerHandle( udg_hash, id, StringHash( "snp" ), CreateTimer() )
    endif
	//call SaveTimerHandle( udg_hash, id, StringHash( "snp" ), CreateTimer( ) ) 
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "snp" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "snp" ), u ) 
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "snp" ) ), 4, false, function SniperPCast ) 
	set u = null
endfunction

function Trig_SniperPD_Conditions takes nothing returns boolean
    return IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and GetUnitAbilityLevel( udg_DamageEventTarget, LEARN_ID) > 0 and udg_DamageEventAmount > 0
endfunction

function Trig_SniperPD takes unit u returns nothing
    local integer id = GetHandleId( u )
    
    call UnitRemoveAbility( u, HANDLER_ID )
    call UnitRemoveAbility( u, ASPD_ID ) 
    call UnitRemoveAbility( u, DMG_ID ) 
    call UnitRemoveAbility( u, BUFF_ID ) 
    call UnitRemoveAbility( u, ALT_HANDLER_ID )
    call UnitRemoveAbility( u, ALT_ASPD_ID ) 
    call UnitRemoveAbility( u, ALT_DMG_ID ) 
    call UnitRemoveAbility( u, ALT_BUFF_ID ) 
    
    //if LoadTimerHandle( udg_hash, id, StringHash( "snp" ) ) == null then
        //call SaveTimerHandle( udg_hash, id, StringHash( "snp" ), CreateTimer() )
    //endif
	//call SaveTimerHandle( udg_hash, id, StringHash( "snp" ), CreateTimer( ) ) 
	//set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "snp" ) ) ) 
	//call SaveUnitHandle( udg_hash, id, StringHash( "snp" ), udg_DamageEventTarget ) 
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "snp" ) ), 4, false, function SniperPCast ) 
endfunction

function Trig_SniperPAR_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel( Event_AspectRemoved_Hero, LEARN_ID) > 0 and Event_AspectRemoved_Key02 == 2
endfunction
function Trig_SniperPAA_Conditions takes nothing returns boolean
    return GetUnitAbilityLevel( Event_AspectAdded_Hero, LEARN_ID) > 0 and Event_AspectAdded_Key02 == 2
endfunction

function Trig_SniperPD_Actions takes nothing returns nothing
	local unit u = udg_DamageEventTarget
    call Trig_SniperPD(u)
    set u = null
endfunction
function Trig_SniperPAR_Actions takes nothing returns nothing
	local unit u = Event_AspectRemoved_Hero
    call Trig_SniperPD(u)
    set u = null
endfunction
function Trig_SniperPAA_Actions takes nothing returns nothing
	local unit u = Event_AspectAdded_Hero
    call Trig_SniperPD(u)
    set u = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_SniperP = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SniperP, EVENT_PLAYER_HERO_SKILL )
    call TriggerAddCondition( trg_SniperP, Condition( function Trig_SniperP_Conditions ) )
    call TriggerAddAction( trg_SniperP, function Trig_SniperP_Actions )
    
    set trg_SniperPD = CreateTrigger(  )
    call TriggerRegisterVariableEvent( trg_SniperPD, "udg_AfterDamageEvent", EQUAL, 1.00 )
    call TriggerAddCondition( trg_SniperPD, Condition( function Trig_SniperPD_Conditions ) )
    call TriggerAddAction( trg_SniperPD, function Trig_SniperPD_Actions )
    
    set trg_SniperPAR = CreateTrigger(  )
    call TriggerRegisterVariableEvent( trg_SniperPAR, "Event_AspectRemoved_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trg_SniperPAR, Condition( function Trig_SniperPAR_Conditions ) )
    call TriggerAddAction( trg_SniperPAR, function Trig_SniperPAR_Actions )
    set trg_SniperPAA = CreateTrigger(  )
    call TriggerRegisterVariableEvent( trg_SniperPAA, "Event_AspectAdded_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trg_SniperPAA, Condition( function Trig_SniperPAA_Conditions ) )
    call TriggerAddAction( trg_SniperPAA, function Trig_SniperPAA_Actions )
endfunction

endscope

