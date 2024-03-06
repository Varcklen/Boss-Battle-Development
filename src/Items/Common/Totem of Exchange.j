scope TotemOfExchange initializer init

	globals
		private constant integer ID_ITEM = 'A17S'
		private constant integer AMOUNT_TO_GAIN = 2
		private constant integer PIECE_TO_GAIN = 1
		
		private integer array StrengthGain[5]
		private integer array AgilityGain[5]
		private integer array IntelligenceGain[5]
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ID_ITEM and udg_fightmod[3] == false and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
	endfunction
	
	private function Use takes unit caster returns nothing
		local integer index = GetUnitUserData(caster)
		local integer rand
		local integer i = 1
		
		loop
			exitwhen i > AMOUNT_TO_GAIN
			set rand = GetRandomInt( 1, 3 )
			if rand == 1 then
				call statst( caster, PIECE_TO_GAIN, 0, 0, 0, true )
				set StrengthGain[index] = StrengthGain[index] + PIECE_TO_GAIN
			elseif rand == 2 then
				call statst( caster, 0, PIECE_TO_GAIN, 0, 0, true )
				set AgilityGain[index] = AgilityGain[index] + PIECE_TO_GAIN
			elseif rand == 3 then
				call statst( caster, 0, 0, PIECE_TO_GAIN, 0, true )
				set IntelligenceGain[index] = IntelligenceGain[index] + PIECE_TO_GAIN
			endif
			set i = i + 1
		endloop
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd 
	    local unit caster
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName('A17S'), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif 
	    
	    call DestroyEffect( AddSpecialEffectTarget( "Blood Explosion.mdx", caster, "origin" ) )
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call Use(caster)
	        set cyclA = cyclA + 1
	    endloop
	    
	    set caster = null
	endfunction
	
	private function DeleteBonus takes nothing returns nothing
		local integer index = GetUnitUserData(Event_BetweenUnit_Hero)
		
		if StrengthGain[index] > 0 or AgilityGain[index] > 0 or IntelligenceGain[index] > 0 then
			call statst( Event_BetweenUnit_Hero, -StrengthGain[index], -AgilityGain[index], -IntelligenceGain[index], 0, true )
			set StrengthGain[index] = 0
			set AgilityGain[index] = 0
			set IntelligenceGain[index] = 0
		endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    
	    call CreateEventTrigger( "Event_BetweenUnit", function DeleteBonus, null )
	    
	    set trig = null
	endfunction

endscope