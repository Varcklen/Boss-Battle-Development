scope Entropy

	globals
		private constant integer LIMIT = 500
		private constant integer PANEL_NUMBER = 3
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\EtherealForm\\SpiritWalkerChange.mdl"
	endglobals

	function entropy takes unit caster, integer valueToAdd returns nothing
	    local integer k = GetPlayerId( GetOwningPlayer( caster ) ) + 1
	    local integer at = 0
	    local integer newValue = valueToAdd + udg_entropy[k]

	    if newValue > LIMIT then
	        set at = LIMIT - udg_entropy[k]
	        set udg_entropy[k] = LIMIT
	    elseif newValue < 0 then
	        set at = -udg_entropy[k]
	        set udg_entropy[k] = 0
	    else
	        set at = valueToAdd
	        set udg_entropy[k] = newValue
	    endif
	    if at != 0 and GetUnitTypeId(caster) == 'O016' then
	        call spdst( caster, at )
	        call BlzSetUnitMaxMana( caster, BlzGetUnitMaxMana(caster) + at * 2  )
	        call LeaderboardSetItemValue( udg_panel[PANEL_NUMBER], LeaderboardGetPlayerIndex( udg_panel[PANEL_NUMBER] , Player(4)), udg_entropy[k] )
	        call spectime( ANIMATION, GetUnitX( caster ), GetUnitY( caster ), 1 )
	    endif
	    set caster = null
	endfunction

endscope