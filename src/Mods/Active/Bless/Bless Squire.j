scope BlessSquire initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[1]
	endfunction
	
	private function Launch takes unit caster returns nothing
		local player owner = GetOwningPlayer(caster)
		
		call CreateUnit( owner, 'h00S', GetUnitX( caster ) + 200, GetUnitY( caster ), 90 )
        call SetPlayerTechResearched( owner, 'R002', GetPlayerTechCount( owner, 'R002', true) + 1 )
        call SetPlayerTechResearched( owner, 'R003', GetPlayerTechCount( owner, 'R003', true) + 1 )
        
        set owner = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		
		call Launch(caster)
		
        set caster = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i
		call EnableTrigger( Trigger )
		if udg_fightmod[1] then
			set i = 1
			loop
				exitwhen i > 4
				if IsUnitAlive(udg_hero[i]) then
					call Launch(udg_hero[i])
				endif
				set i = i + 1
			endloop
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