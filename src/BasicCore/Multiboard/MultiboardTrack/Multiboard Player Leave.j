scope MultiboardPlayerLeave initializer init

	private function action takes nothing returns nothing
		local integer index = Event_PlayerLeave_Index
		local integer columnPos = Multiboard_GetPlayerColumn(index)
		local integer i
	
		if not( IsVictory ) and not( IsDefeat ) then
			call StartSound( gg_snd_SpellbreakerWarcry1 )
            set udg_DamageFight[index] = 0
            set udg_HealFight[index] = 0
            set udg_ManaFight[index] = 0
            set udg_ManaAllTime[index] = 0
            set udg_HealAllTime[index] = 0
            set udg_DamageAllTime[index] = 0
            set udg_DamagedAllTime[index] = 0
            set udg_DamagedFight[index] = 0
            call Multiboard_MultiSetIcon( 3, columnPos, "ReplaceableTextures\\CommandButtons\\BTNCritterChicken.blp" )
            set i = 1
            loop
                exitwhen i > 3
                call Multiboard_MultiSetIcon( 15, columnPos + i, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp" )
                set i = i + 1
            endloop
		endif
		
		set i = 3
        loop
            exitwhen i > 14
            call Multiboard_MultiSetColor( i, columnPos, 70.00, 70.00, 70.00, 25.00 )
            set i = i + 1
        endloop
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_PlayerLeave_Real", function action, null )
	endfunction
	
endscope