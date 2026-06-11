library LegionaryRubies initializer init requires SpecAnimLib

	globals
		private constant integer LIMIT = 500
		private constant integer ATTACK_PER_RUBY = 2
	endglobals

	private function ChangeValue takes unit caster, integer valueToAdd returns nothing
		set udg_cristal = udg_cristal + valueToAdd
		call BlzSetUnitBaseDamage( caster, BlzGetUnitBaseDamage(caster, 0) + ATTACK_PER_RUBY * valueToAdd, 0 )
        call LeaderboardSetItemValue( udg_panel[1], LeaderboardGetPlayerIndex( udg_panel[1] , Player(4)), udg_cristal )
        call spectime("Abilities\\Spells\\Orc\\EtherealForm\\SpiritWalkerChange.mdl", GetUnitX( caster ), GetUnitY( caster ), 1 )
	endfunction

	// Пылающие кристаллы
	function crist takes unit caster, integer valueToAdd returns nothing
	    local integer newValue = valueToAdd + udg_cristal
	
	    if newValue > LIMIT then
	        set valueToAdd = LIMIT - udg_cristal
	    elseif newValue < 0 then
	        set valueToAdd = -udg_cristal
	    endif

	    if valueToAdd != 0 then
	        call ChangeValue(caster, valueToAdd)
	    endif
	    set caster = null
	endfunction
	
	//===========================================================================
    private function OnBattleEnd_Condition takes nothing returns boolean
	    return GetUnitAbilityLevel(BattleEnd.GetDataUnit("caster"), 'A1EH') > 0
	endfunction
    
	private function OnBattleEnd takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		
		call crist(caster, -udg_cristal)
	    
	    set caster = null
	endfunction
	
	//===========================================================================	
	private function init takes nothing returns nothing
	    call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	endfunction

endlibrary