library BuffsLibLib requires Inventory, LuckylogicLib, UnitstLib, CombatLib, TextLib

	/*function BuffLogic takes nothing returns boolean
        local boolean l = true
        
        if udg_BuffLogic then
            set udg_BuffLogic = false
            set l = false
        endif
        return l
    endfunction*/
    
    function RemoveEffect takes unit target, integer myEffect, integer myBuff returns nothing
        call UnitRemoveAbility(target, myEffect)
        call UnitRemoveAbility(target, myBuff)
    
        set target = null
    endfunction

endlibrary