library CastLib 

	globals
		private boolean IsForceCast = false
		private boolean IsRandomCast = false
	endglobals

	// Логика срабатывания доп.заклинания
	function CastLogic takes nothing returns boolean
	    if IsForceCast then
	    	//call BJDebugMsg("Caster logic enabled")
	        set IsForceCast = false
	        return true
        elseif RandomMode == false then
        	set udg_TrigNow = GetTriggeringTrigger()
	    endif
	    return false
	endfunction
	
	function RandomLogic takes nothing returns boolean
	    if IsRandomCast then
	        set IsRandomCast = false
	        return true
	    endif
	    return false
	endfunction

	public function CastRandomAbility takes unit caster, trigger abilityUsed, integer abilityLevel returns nothing
		if caster == null or abilityUsed == null or abilityLevel < 0 or abilityLevel > 5 then
            call BJDebugMsg("Warning! Cannot use random ability!")
            call BJDebugMsg("caster: " + GetUnitName(caster) )
            call BJDebugMsg("level: " + I2S(abilityLevel) )
            return
        endif
	
		set IsRandomCast = true
        set udg_Caster = caster
        set udg_Level = abilityLevel
        
        set RandomMode = true
        call TriggerExecute( abilityUsed )
        set RandomMode = false
	endfunction
	
	public function CastAbility takes unit caster, unit target, trigger abilityUsed, integer abilityLevel, real duration returns nothing
		if caster == null or abilityUsed == null or abilityLevel < 0 or abilityLevel > 5 then
            call BJDebugMsg("Warning! Cannot use force ability!")
            call BJDebugMsg("caster: " + GetUnitName(caster) )
            call BJDebugMsg("level: " + I2S(abilityLevel) )
            if abilityUsed == null then
                call BJDebugMsg("abilityUsed is null")
            endif
            return
        endif
        
        /*call BJDebugMsg("caster: " + GetUnitName(caster) )
        call BJDebugMsg("target: " + GetUnitName(target) )
        call BJDebugMsg("level: " + I2S(abilityLevel) )*/
        //call BJDebugMsg("trigger: " + BlzGetTriggerFrameText())
        
		set IsForceCast = true
        set udg_Caster = caster
        set udg_Target = target

        set udg_Level = abilityLevel
        set udg_Time = duration
        call TriggerExecute( abilityUsed )
	endfunction
	
endlibrary