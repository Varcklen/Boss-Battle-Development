scope SacredStone initializer init

    globals
        private constant integer ID_ABILITY = 'AZ05'
        private constant integer ID_ITEM = 'IZ01'
        private constant integer MULTIPLIER = 2
        private constant integer CAP = 100000
    endglobals

    private function conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

	private function actions takes nothing returns nothing
	    local unit caster
	    local unit target
	    local integer cyclA = 1
	    local integer cyclAEnd
	    local integer pwr = 80
	    local integer dmg
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "enemy", "", "", "", "" )
	        call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif
	    
	    set cyclAEnd = 0
	    if udg_hero[1] != null then 
	    set cyclAEnd = cyclAEnd + inv(udg_hero[1], ID_ITEM)
	    endif
	    if udg_hero[2] != null then 
	    set cyclAEnd = cyclAEnd + inv(udg_hero[2], ID_ITEM)
	    endif
	    if udg_hero[3] != null then 
	    set cyclAEnd = cyclAEnd + inv(udg_hero[3], ID_ITEM)
	    endif
	    if udg_hero[4] != null then 
	    set cyclAEnd = cyclAEnd + inv(udg_hero[4], ID_ITEM)
	    endif
	    set cyclAEnd = IMinBJ(cyclAEnd, 20)
    	//call BJDebugMsg("cyclAEnd: " + I2S(cyclAEnd))
	    loop
	        exitwhen cyclA > cyclAEnd
	        set pwr = pwr * MULTIPLIER
    		//call BJDebugMsg("pwr: " + I2S(pwr))
	        set cyclA = cyclA + 1
	    endloop
	    set dmg = IMinBJ(pwr, CAP)
    	//call BJDebugMsg("dmg: " + I2S(dmg))
	    
	    set cyclA = 1
	    set cyclAEnd = eyest( caster )
	    call dummyspawn( caster, 1, 0, 0, 0 )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call UnitDamageTarget( bj_lastCreatedUnit, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    		//call BJDebugMsg("dmg: " + I2S(dmg))
	        call healst( caster, null, pwr )
	        call manast( caster, null, pwr )
	        call shield( caster, caster, pwr )
    		//call BJDebugMsg("pwr: " + I2S(pwr))
	        
	        set cyclA = cyclA + 1
	    endloop
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	 private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig, Condition( function conditions ) )
	    call TriggerAddAction( trig, function actions )
	    set trig = null
	endfunction

endscope
