scope CurseSeeker initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function RemoveProjectile takes unit projectile returns nothing
		call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", GetUnitX(projectile), GetUnitY(projectile)) )
        call RemoveUnit( projectile )
	endfunction
	
	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit projectile = LoadUnitHandle( udg_hash, id, StringHash( "curse_seeker_end" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "curse_seeker_end_target" ) )
	    
	    if IsUnitAlive( target) then
	        if DistanceBetweenUnits(target, projectile) < 50 then
	            call UnitDamageTarget(projectile, target, GetUnitState( target, UNIT_STATE_MAX_LIFE) * 0.1, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	            if IsUnitAlive(target) then
	                call UnitStun(projectile, target, 2 )
	            endif
	            call RemoveProjectile(projectile)
	            call DestroyTimer( GetExpiredTimer() )
	        else
	            call IssuePointOrder( projectile, "move", GetUnitX( target ), GetUnitY( target ) )
	        endif
	    else
	        call RemoveProjectile(projectile)
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set target = null
	    set projectile = null
	endfunction 

	private function LimitValue takes real value returns real
		if value > -400 then
            return -400.
        elseif value < 400 then
            return 400.
        endif
        return value
	endfunction

	private function spawn takes nothing returns nothing
		local unit target = DeathSystem_GetRandomAliveHero()
		local real x
	    local real y
	    local integer id
	
		if target == null then
			return
		endif
	
		set x = LimitValue(GetRandomReal(-800, 800))
        set y = LimitValue(GetRandomReal(-800, 800))
        
        set bj_lastCreatedUnit = CreateUnit( Player(10), 'u000', GetUnitX( target ) + x, GetUnitY( target ) + y, 270 )
        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
        call SetUnitScale(bj_lastCreatedUnit, 2, 2, 2 )
        call UnitAddAbility( bj_lastCreatedUnit, 'A0Z7')
        call SetUnitMoveSpeed( bj_lastCreatedUnit, 200 )
        call IssuePointOrder( bj_lastCreatedUnit, "move", GetUnitX( target ), GetUnitY( target ) )
        
        set id = InvokeTimerWithUnit( bj_lastCreatedUnit, "curse_seeker_end", 0.2, true, function end )
        call SaveUnitHandle( udg_hash, id, StringHash( "curse_seeker_end_target" ), target )
        
	    set target = null
	endfunction

	private function cast takes nothing returns nothing
	    if not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call spawn()
	    endif
	endfunction

    private function action takes nothing returns nothing
    	local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash("curse_seeker") )
        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash("curse_seeker"), timerUsed )
        endif
        call TimerStart( timerUsed, 30, true, function cast )
        
        set timerUsed = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
			call spawn()
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