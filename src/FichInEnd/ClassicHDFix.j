scope ClassicHDFix initializer init

private function fix takes nothing returns nothing
	local unit u = GetEnteringUnit()
	call SetUnitSkin( u, 'N03D' )
	call SetUnitSkin( u, GetUnitTypeId(u) )
	set u = null
endfunction

private function init takes nothing returns nothing
	local trigger trg = CreateTrigger()
    call TriggerRegisterEnterRectSimple( trg, GetWorldBounds() )
	call TriggerAddAction(trg, function fix)
	set trg = null
endfunction

endscope