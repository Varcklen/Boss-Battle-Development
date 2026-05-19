library BookSeller initializer init requires EventDatabase

	globals
		private unit array BookSeller[5]
		private boolean array IsActive[5]
	endglobals
	
	public function Enable takes unit hero returns nothing
		local integer index = GetPlayerId( GetOwningPlayer( hero ) )
		if IsActive[index] then
			return
		endif
		set IsActive[index] = true
		call ShowUnit(BookSeller[index], true)
		call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX(BookSeller[index]), GetUnitY(BookSeller[index]) ) )
	endfunction
	
	public function Disable takes unit hero returns nothing
		local integer index = GetPlayerId( GetOwningPlayer( hero ) )
		if IsActive[index] == false then
			return
		endif
		set IsActive[index] = false
		call ShowUnit(BookSeller[index], false)
	endfunction

	private function OnBattleStart takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		
		call Disable(caster)
		
		set caster = null
	endfunction

	//===========================================================================
	private function hide takes nothing returns nothing
		local integer i = 0
		
		set BookSeller[0] = udg_UNIT_BOOK_SELLER_RED
		set BookSeller[1] = udg_UNIT_BOOK_SELLER_BLUE
		set BookSeller[2] = udg_UNIT_BOOK_SELLER_TEAL
		set BookSeller[3] = udg_UNIT_BOOK_SELLER_PURPLE
		
		loop
			exitwhen i >= 4
			call ShowUnit(BookSeller[index], false)
			set i = i + 1
		endloop
	endfunction
	
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, udg_StartTimer )
	    call TriggerAddAction( trig, function hide )
	    set trig = null
	    
	    call BattleStart.AddListener(function OnBattleStart, null)
	endfunction

endlibrary