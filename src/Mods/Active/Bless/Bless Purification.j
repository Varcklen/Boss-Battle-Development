scope BlessPurification initializer init

	globals
		private trigger Trigger = null
		
		private constant integer ITEM_TO_ADD = 'I0DW'
	endglobals
	
	private function condition takes nothing returns boolean
		return not(udg_fightmod[3]) and ItemManipulation_IsInventoryFull(BattleStart.TriggerUnit) == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")

        call UnitAddItem( hero, CreateItem(ITEM_TO_ADD, GetUnitX(hero), GetUnitY(hero) ) )
        
        set hero = null
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
		set Trigger = BattleStart.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope