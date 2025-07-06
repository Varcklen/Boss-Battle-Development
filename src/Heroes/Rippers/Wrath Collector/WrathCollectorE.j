scope WrathCollectorE initializer init

	globals
		private constant integer ABILITY_ID = 'A1GV'
		
		private constant real DURATION = 2
		private constant real TICK_PERIOD = 0.5 
		private constant integer EFFECT_ID = 'A1GY'
		private constant integer BUFF_ID = 'B0AR'
		
		private constant integer HEAL_INITIAL = 10
		private constant integer HEAL_PER_LEVEL = 10
		
		private constant integer CHARGE_CONSUME = 5
		
		private constant integer MAIN_KEY = StringHash("wrath_collector_e_buff")
		
		trigger WrathCollectorE = null
	endglobals

	private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ABILITY_ID
    endfunction
    
    private function BuffCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
		local integer counter = LoadInteger( udg_hash, id, StringHash( "wrath_collector_e_buff_counter" ) )
		local integer ticks = 	LoadInteger( udg_hash, id, StringHash( "wrath_collector_e_buff_ticks" ) )
	    local real heal = 		LoadReal( udg_hash, id, StringHash( "wrath_collector_e_buff_heal" ) )
	    local unit caster = 	LoadUnitHandle( udg_hash, id, StringHash( "wrath_collector_e_buff_caster" ) )
	
	    if IsUnitAlive( caster ) then
	        call healst( caster, null, heal )
	        call WrathBarEffect_AddValue(caster, -CHARGE_CONSUME)
	    endif
	    /*call BJDebugMsg("=============")
	    call BJDebugMsg("counter: " + I2S(counter))
	    call BJDebugMsg("ticks: " + I2S(ticks))*/
	    if counter < ticks and IsUnitAlive( caster) and GetUnitAbilityLevel( caster, EFFECT_ID) > 0 then
	        call SaveInteger( udg_hash, id, StringHash( "wrath_collector_e_buff_counter" ), counter + 1 )
	    else
	        call UnitRemoveAbility( caster, EFFECT_ID )
	        call UnitRemoveAbility( caster, BUFF_ID )
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    endif
	    
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id
	    local integer lvl
	    local unit caster
	    local real heal
	    local real duration
	    local timer usedTimer
	    local integer ticks
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set duration = udg_Time
	        set lvl = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        set duration = DURATION
	        set lvl = udg_Level
	    else
	        set caster = GetSpellAbilityUnit()
	        set duration = DURATION
	        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
	    endif
	    set duration = timebonus(caster, duration)
	    set ticks = R2I(duration/TICK_PERIOD) - 1
	    /*call BJDebugMsg("ticks: " + I2S(ticks))
	    call BJDebugMsg("duration: " + R2S(duration))*/
	    
	    set heal = HEAL_INITIAL + HEAL_PER_LEVEL * lvl
	    call UnitAddAbility( caster, EFFECT_ID )
	    
	    if LoadTimerHandle( udg_hash, GetHandleId( caster ), MAIN_KEY ) == null then
	        call SaveTimerHandle( udg_hash, GetHandleId( caster ), MAIN_KEY, CreateTimer() )
	    endif
	    set usedTimer = LoadTimerHandle( udg_hash, GetHandleId( caster ), MAIN_KEY )
		set id = GetHandleId( usedTimer ) 
		call SaveUnitHandle( udg_hash, id, StringHash( "wrath_collector_e_buff_caster" ), caster )
	    call SaveReal( udg_hash, id, StringHash( "wrath_collector_e_buff_heal" ), heal )
	    call SaveInteger( udg_hash, id, StringHash( "wrath_collector_e_buff_ticks" ), ticks )
		call TimerStart( usedTimer, TICK_PERIOD, true, function BuffCast )
	    
	    set caster = null
	    set usedTimer = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
    	set WrathCollectorE = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope