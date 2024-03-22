scope BlessSquire initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[1]
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local player owner = GetOwningPlayer(caster)
		
		call CreateUnit( owner, 'h00S', GetUnitX( caster ) + 200, GetUnitY( caster ), 90 )
        call SetPlayerTechResearched( owner, 'R002', GetPlayerTechCount( owner, 'R002', true) + 1 )
        call SetPlayerTechResearched( owner, 'R003', GetPlayerTechCount( owner, 'R003', true) + 1 )
        
        set caster = null
        set owner = null
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
		set Trigger = BattleStart.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope