scope CurseElectricStorm initializer init

	globals
		private trigger Trigger = null
		
		constant integer STORM_COOLDOWN = 15
        constant integer STORM_TIME_TO_ACTIVATION = 3
        constant integer STORM_HOW_MUCH = 15
        constant integer STORM_AREA = 128
        
        constant real DAMAGE_PERC = 0.2
        
        constant string STORM_WARNING = "war3mapImported\\AuraOfDeath.mdx"
        constant string STORM_LIGHTNING = "Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl"
	endglobals
	
    private function Storm_Use takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local effect storm = LoadEffectHandle( udg_hash, id, StringHash( "curse_el_storm_fx" ) )
        local group g = CreateGroup()
        local unit u
        local real x = BlzGetLocalSpecialEffectX( storm )
        local real y = BlzGetLocalSpecialEffectY( storm )
        
        set bj_lastCreatedUnit = CreateUnit( Player( 10 ), 'u000', 0, 0, 270 )
        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1)
        call GroupEnumUnitsInRange( g, x, y, STORM_AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, bj_lastCreatedUnit, "enemy" ) then
                call UnitTakeDamage(bj_lastCreatedUnit, u, GetUnitState(u, UNIT_STATE_MAX_LIFE) * DAMAGE_PERC, DAMAGE_TYPE_MAGIC)
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyEffect( AddSpecialEffect( STORM_LIGHTNING, x, y ) )
        call DestroyEffect( storm )
        
        call DestroyTimer( GetExpiredTimer() )
        
        call DestroyGroup( g )
        set u = null
        set g = null
        set storm = null
    endfunction

    private function Storm_Start takes nothing returns nothing
        local effect storm
        local Math_point lightPoint 
        local integer i

        if udg_fightmod[0] == false then
            call DestroyTimer( GetExpiredTimer() )
        else
            set i = 1
            loop
                exitwhen i > STORM_HOW_MUCH
                set lightPoint = GetRandomPointInRect(udg_Boss_Rect)
                set storm = AddSpecialEffect(STORM_WARNING, lightPoint.x, lightPoint.y)
                call InvokeTimerWithEffect(storm, "curse_el_storm_fx", STORM_TIME_TO_ACTIVATION, false, function Storm_Use )
                set i = i + 1
            endloop
        endif
        
        call lightPoint.destroy()
        set storm = null
    endfunction

    private function action takes nothing returns nothing
    	local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash("curse_el_storm") )
        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash("curse_el_storm"), timerUsed )
        endif
        call TimerStart( timerUsed, STORM_COOLDOWN, true, function Storm_Start )
        
        set timerUsed = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope