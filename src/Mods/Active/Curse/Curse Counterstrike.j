scope CurseCounterstrike initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return GetOwningPlayer(GetEnteringUnit()) == Player(10) and GetUnitTypeId(GetEnteringUnit()) != 'u000'
	endfunction
	
	private function action takes nothing returns nothing
		call UnitAddAbility( GetEnteringUnit(), 'A0SV' )
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