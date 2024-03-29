scope BlessSap initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[1]
	endfunction
	
	private function end takes nothing returns nothing
	    local unit boss = MainBoss
	    
	    if IsUnitAlive(boss) then
		    call SetUnitLifePercentBJ( boss, GetUnitLifePercent(boss) - 10 )
		    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", boss, "origin") )
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		//call SaveUnitHandle( udg_hash, 1, StringHash( "mod_sap" ), MainBoss )
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