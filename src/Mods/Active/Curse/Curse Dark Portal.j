scope CurseDarkPortal initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType(GetEnteringUnit(), UNIT_TYPE_ANCIENT) and GetOwningPlayer(GetEnteringUnit()) == Player(10) and GetUnitDefaultMoveSpeed(GetEnteringUnit()) != 0
	endfunction
	
	private function use takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "curse_dark_portal" ) )
	    local unit target = DeathSystem_GetRandomAliveHero()
	
	    if IsUnitDead(boss) or udg_fightmod[0] == false then
	        call DestroyTimer( GetExpiredTimer() )
	    elseif target != null and IsUnitHiddenBJ(boss) == false then
	    
	        call DestroyEffect( AddSpecialEffect("Void Teleport Caster.mdx", GetUnitX(boss), GetUnitY(boss) ) )
	        call SetUnitPosition( boss, GetUnitX(target)+GetRandomReal(-200,200), GetUnitY(target)+GetRandomReal(-200,200) )
	        if RectContainsUnit( udg_Boss_Rect, boss) == false then
	            call SetUnitPositionLoc( boss, GetRectCenter( udg_Boss_Rect ) )
	        endif
	        call DestroyEffect( AddSpecialEffectTarget("Void Teleport Caster.mdx", boss, "origin" ) )
	        call taunt( target, boss, 4 )
	        
	    endif
	
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		call InvokeTimerWithUnit( GetEnteringUnit(), "curse_dark_portal", 20, false, function use )
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( Trigger, GetWorldBounds() )
	    call TriggerAddCondition( Trigger, Condition( function condition ) )
	    call TriggerAddAction( Trigger, function action )
		call DisableTrigger( Trigger )
	endfunction

endscope