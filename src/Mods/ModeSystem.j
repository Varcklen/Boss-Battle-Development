library ModeSystem requires ModeClass, ModeUse

	public function GetRandomBless takes boolean getActive returns Mode
		if getActive then
			return ModeClass_ActiveBlesses.GetRandomCell()
		endif
		return ModeClass_InactiveBlesses.GetRandomCell()
	endfunction
	
	public function GetRandomCurse takes boolean getActive returns Mode
		if getActive then
			return ModeClass_ActiveCurses.GetRandomCell()
		endif
		return ModeClass_InactiveCurses.GetRandomCell()
	endfunction
	
	public function Enable takes Mode modeUsed returns nothing
		local integer id 
		local integer info 
		
		if modeUsed == -1 or modeUsed == 0 then
			call BJDebugMsg("Error! ModeSystem_Enable: modeUsed is null!")
			return 
		endif
		
		set id = modeUsed.id
		set info = modeUsed.Info
		
		call IconFrame( "ModGood" + I2S(id), BlzGetAbilityIcon(info), BlzGetAbilityTooltip(info, 0), BlzGetAbilityExtendedTooltip(info, 0) )
		call modeUsed.SetState(true)
		call ModeUse_EnableTrigger(modeUsed)
	endfunction
	
	public function Disable takes Mode modeUsed returns nothing
		local integer id 
		
		if modeUsed == -1 or modeUsed == 0 then
			call BJDebugMsg("Error! ModeSystem_Disable: modeUsed is null!")
			return 
		endif
		
		set id = modeUsed.id
		
		call IconFrameDel( "ModGood" + I2S(id) )
		call modeUsed.SetState(false)
		call ModeUse_DisableTrigger(modeUsed)
	endfunction

endlibrary