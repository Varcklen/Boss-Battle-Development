scope CursePowerMagic initializer init

	globals
		private trigger Trigger = null
	endglobals

    private function condition takes nothing returns boolean
		return GetOwningPlayer(GetEnteringUnit()) == Player(10)
	endfunction
	
	private function action takes nothing returns nothing
		call UnitAddAbility( GetEnteringUnit(), 'A10Y' )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		call SpellPower_AddBossSpellPower(0.15)
    endfunction
    
    public function Disable takes nothing returns nothing
    	call DisableTrigger( Trigger )
		call SpellPower_AddBossSpellPower(-0.15)
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( Trigger, GetWorldBounds() )
	    call TriggerAddCondition( Trigger, Condition( function condition ) )
	    call TriggerAddAction( Trigger, function action )
		call DisableTrigger( Trigger )
	endfunction

endscope