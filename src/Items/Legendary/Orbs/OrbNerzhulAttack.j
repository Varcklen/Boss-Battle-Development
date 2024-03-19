scope OrbNerzhulAttack initializer init

	private function condition takes nothing returns boolean
		if GetUnitAbilityLevel( AfterAttack.TriggerUnit, 'B029') == 0 then
			return false
	    elseif IsUnitType( AfterAttack.TargetUnit, UNIT_TYPE_HERO) then
	        return false
	    elseif IsUnitType( AfterAttack.TargetUnit, UNIT_TYPE_ANCIENT) then
	        return false
	    elseif udg_IsDamageSpell then
	        return false
	    elseif luckylogic( AfterAttack.TriggerUnit, 8, 1, 100 ) == false then
	        return false
	    elseif IsUnitDead(AfterAttack.TargetUnit) then
	        return false
	    endif
	
	    return true
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
		local unit target = AfterAttack.GetDataUnit("target")
		
	    call PlaySpecialEffect("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl", target)
	    if IsPermaBuffAffected(target) then
	        call SetUnitOwner( target, GetOwningPlayer(caster), true )
	        call UnitApplyTimedLife( target, 'BTLF', 30 )
	    endif
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call AfterAttack.AddListener(function action, function condition)
	endfunction

endscope