scope ImmovableMantle initializer init

    globals
        private constant integer ID_ABILITY = 'A1HK'
        
        private constant integer DURATION = 7
        private constant integer TICK = 1
        
        private constant integer EFFECT = 'A107'
        private constant integer BUFF = 'B04A'
        
    	private constant string ANIMATION = "Objects\\Spawnmodels\\Undead\\UCancelDeath\\UCancelDeath.mdl"
        
    endglobals

    private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function tick takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "imomant" ) )
	    
	    if GetUnitAbilityLevel( u, EFFECT ) > 0 then
	        call pausest( u, -1 )
	        call IssueImmediateOrder( u, "stop" )
	        call UnitRemoveAbility( u, EFFECT )
	        call UnitRemoveAbility( u, BUFF )
	    endif
	    call FlushChildHashtable( udg_hash, id )
	
		set u = null
	endfunction

    private function action takes nothing returns nothing
        local integer lvl
        local unit caster
        local real duration
        local integer id
        
        if CastLogic() then
            set caster = udg_Caster
            set duration = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set duration = DURATION
        else
            set caster = GetSpellAbilityUnit()
            set duration = DURATION
	    endif
	    set duration = timebonus(caster, duration)
	    
	    set id = GetHandleId( caster )
	    
	    if GetUnitAbilityLevel( caster, EFFECT ) == 0 then
	        call pausest( caster, 1 )
	    endif
	    call UnitAddAbility( caster, EFFECT )
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "chest" ) )
	    
	    if LoadTimerHandle( udg_hash, id, StringHash( "imomant" ) ) == null then
	        call SaveTimerHandle( udg_hash, id, StringHash( "imomant" ), CreateTimer() )
	    endif
		set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "imomant" ) ) ) 
		call SaveUnitHandle( udg_hash, id, StringHash( "imomant" ), caster )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "imomant" ) ), duration, false, function tick )
	    
	    set caster = null
    endfunction
    
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit u = Event_DeleteBuff_Unit

        if GetUnitAbilityLevel( u, EFFECT ) > 0 then
	        call pausest( u, -1 )
	        call IssueImmediateOrder( u, "stop" )
	        call UnitRemoveAbility( u, EFFECT )
	        call UnitRemoveAbility( u, BUFF )
	    endif
        
        set u = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction

endscope

