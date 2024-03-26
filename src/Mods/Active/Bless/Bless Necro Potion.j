scope BlessNecroPotion initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return not( udg_fightmod[3] ) and combat( AnyHeroDied.TargetUnit, false, 0 ) and IsUnitAlive(AnyHeroDied.TriggerUnit) and AnyHeroDied.TargetUnit != AnyHeroDied.TriggerUnit and UnitInventoryCount(AnyHeroDied.TriggerUnit) < UnitInventorySize(AnyHeroDied.TriggerUnit)
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyHeroDied.GetDataUnit("caster")
		local integer itemId = udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])]
		
        call UnitAddItem( caster, CreateItem( itemId, GetUnitX( caster ), GetUnitY(caster)) )
        
        set caster = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope