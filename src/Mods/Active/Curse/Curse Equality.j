scope CurseEquality initializer init

	globals
		private trigger TriggerStart = null
		private trigger TriggerEnd = null
		private trigger DamageTrigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return GetUnitLifePercent(udg_DamageEventTarget) <= 50 and IsUnitInGroup( udg_DamageEventTarget, udg_Bosses )
	endfunction

	private function action takes nothing returns nothing
	    local integer i = 1
	
	    call DisableTrigger( GetTriggeringTrigger() )
	    loop
	        exitwhen i > 4
	        if IsUnitAlive( udg_hero[i]) then
	            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl", GetUnitX(udg_hero[i]), GetUnitY(udg_hero[i])) )
	            call SetUnitState( udg_hero[i], UNIT_STATE_LIFE, GetUnitState( udg_hero[i], UNIT_STATE_LIFE) - (GetUnitState( udg_hero[i], UNIT_STATE_MAX_LIFE) * 0.2 ) )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function action_launch takes nothing returns nothing
		if udg_fightmod[1] then
			call EnableTrigger( DamageTrigger )
		endif
	endfunction
	
	private function action_end takes nothing returns nothing
		call DisableTrigger( DamageTrigger )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( TriggerStart )
		call EnableTrigger( TriggerEnd )
		call action_launch()
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( TriggerStart )
		call DisableTrigger( TriggerEnd )
		call DisableTrigger( DamageTrigger )
    endfunction
	
	private function init takes nothing returns nothing
		set DamageTrigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger( DamageTrigger )
		
		set TriggerStart = CreateEventTrigger( "udg_FightStartGlobal_Real", function action_launch, null )
		call DisableTrigger( TriggerStart )
		
		set TriggerEnd = CreateEventTrigger( "udg_FightEndGlobal_Real", function action_end, null )
		call DisableTrigger( TriggerEnd )
	endfunction

endscope