scope CurseSupport initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[1]
	endfunction
	
	private function Summon takes unit boss returns nothing
		set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(boss), udg_Database_RandomUnit[GetRandomInt(1, udg_Database_NumberItems[5])], GetUnitX(boss), GetUnitY(boss), GetUnitFacing(boss))
        call DestroyEffect(AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", bj_lastCreatedUnit, "origin"))
        call UnitApplyTimedLife(bj_lastCreatedUnit, 'BTLF', 20 )
	endfunction
	
	private function end takes nothing returns nothing
	    local unit boss = MainBoss
	    local integer i
	    local integer iMax

	    if IsUnitAlive(boss) then
		    set i = 1
	        set iMax = IMaxBJ(1, udg_Boss_LvL - 1 )
	        loop
	            exitwhen i > iMax
	            call Summon(boss)
	            set i = i + 1
	        endloop
	    endif

	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		//call SaveUnitHandle( udg_hash, 1, StringHash( "mod_support" ), MainBoss )
        call TimerStart( CreateTimer(), 1, false, function end )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		call ConditionalTriggerExecute( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope