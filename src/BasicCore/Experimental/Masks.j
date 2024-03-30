scope Masks initializer init

	globals
		private integer array Masks
		private integer Masks_Max = -1
	endglobals

	private function action takes nothing returns nothing
	    if GetUnitAbilityLevel(GetEnteringUnit(), 'A1FY') > 0 then
	    	return
	    endif
	    
	    call UnitAddAbility(GetEnteringUnit(), Masks[GetRandomInt(0, Masks_Max)])
	endfunction

	private function Add takes integer mask returns nothing
		set Masks_Max = Masks_Max + 1
		set Masks[Masks_Max] = mask
	endfunction

	private function Set takes nothing returns nothing
		call Add('A1G6')
		call Add('A1G7')
		call Add('A1G8')
		call Add('A1G9')
		call Add('A1GA')
		call Add('A1GB')
		call Add('A1GC')
		call Add('A1GD')
		call Add('A1GE')
		call Add('A1GF')
		call Add('A1GG')
		call Add('A1GH')
		call Add('A1GI')
		call Add('A1GJ')
		call Add('A1GK')
		call Add('A1GL')
		call Add('A1GM')
	endfunction

	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
		
	    call TriggerRegisterEnterRectSimple( trig, bj_mapInitialPlayableArea )
	    call TriggerAddAction( trig, function action )
	    
	    call Set()
	    
	    set trig = null
	endfunction

endscope