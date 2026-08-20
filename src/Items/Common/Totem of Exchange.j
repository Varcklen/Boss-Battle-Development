scope TotemOfExchange initializer init

	globals
		private constant integer ID_ITEM = 'A17S'
		private constant integer AMOUNT_TO_GAIN = 2
		private constant integer PIECE_TO_GAIN = -1
		private constant real HP_RESTORE_PERCENT = 0.6
		private constant real MP_RESTORE_PERCENT = 0.6
		
		private string ANIMATION = "Blood Explosion.mdx"
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ID_ITEM and udg_fightmod[3] == false and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
	endfunction
	
	private function Use takes unit caster returns nothing
		local integer index = GetUnitUserData(caster)
		local integer rand
		local integer i = 1
		
		call healst(caster, null, HP_RESTORE_PERCENT * GetUnitState( caster, UNIT_STATE_LIFE) )
		call manast(caster, null, MP_RESTORE_PERCENT * GetUnitState( caster, UNIT_STATE_MANA) )
		loop
			exitwhen i > AMOUNT_TO_GAIN
			set rand = GetRandomInt( 1, 3 )
			if rand == 1 and GetHeroStr( caster, false) > 1 then
				call statst( caster, PIECE_TO_GAIN, 0, 0, 0, false )
			elseif rand == 2 and GetHeroAgi( caster, false) > 1 then
				call statst( caster, 0, PIECE_TO_GAIN, 0, 0, false )
			elseif rand == 3 and GetHeroInt( caster, false) > 1 then
				call statst( caster, 0, 0, PIECE_TO_GAIN, 0, false )
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
	        call textst( udg_string[0] + GetObjectName(ID_ITEM), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif 
	    
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call Use(caster)
	        set cyclA = cyclA + 1
	    endloop

	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope