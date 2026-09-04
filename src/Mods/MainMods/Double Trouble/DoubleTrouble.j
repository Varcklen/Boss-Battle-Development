scope DoubleTrouble initializer init

	globals
		private boolean isActive = false
		private boolean isEnabledToActivate = false
		//private boolean isMoneyBonusDisabled = false
		
		/*private trigger Trigger_Start_Extra = null
		private trigger Trigger_End_Extra = null*/
		private trigger Trigger_End_Boss = null
		private trigger Trigger_OnBossDeath = null
		
		private constant integer ABILITY_USED = 'A0JO'
		private constant integer ADDITIONAL_BATTLE_TIME = 120
		
		private constant integer BUTTON_INDEX = 3
		
		private constant integer EXPERIENCE_BONUS_PERC = 15
		
		private constant integer MONEY_GAIN_MULTIPLIER = 40
		private constant integer GOLD_GAIN_PER_BOSS_LEVEL = 100
		
		private constant integer REVENGE_EFFECT = 'A1HP'
		private constant integer REVENGE_DAMAGE = 'A1HQ'
		private constant integer REVENGE_IGNORE = 'A1HR'
	endglobals
	
	//A1HP - effect
	//A1HQ - damage effect
	//B0AV - buff
	//A1HR - revenge ignore
	
	public function IsEnabled takes nothing returns boolean
	    return isActive
	endfunction
	
	//===============================================================
	private function OnBossDeath_Condition takes nothing returns boolean
	    return udg_fightmod[1] and IsUnitHasAbility( GetDyingUnit(), REVENGE_IGNORE) == false and IsUnitInGroup(GetDyingUnit(), udg_Bosses) 
	endfunction

	private function EnableRevenge takes unit boss returns nothing
		if IsUnitDead(boss) then
			return
		endif
		if IsUnitHasAbility( boss, REVENGE_EFFECT) then
			return
		endif
		call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl", boss, "origin") )
		call UnitAddAbility(boss, REVENGE_EFFECT)
		call UnitAddAbility(boss, REVENGE_DAMAGE)
	endfunction

	private function OnBossDeath takes nothing returns nothing
		local unit u 
		local group g = CreateGroup()
	
		call GroupAddGroup( udg_Bosses, g )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        call EnableRevenge(u)
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set g = null
	    set u = null
	endfunction
	
	//===============================================================
	private function OnBattleEnd_Boss_Condition takes nothing returns boolean
	    return isActive and BattleEndGlobal.GetDataBoolean("is_win") and ExtraArenaGeneral_IsPvPActive() == false
	endfunction

	private function OnBattleEnd_Boss takes nothing returns nothing
		local integer i

		set i = 1
	    loop 
	        exitwhen i > 4
	        if GetPlayerSlotState(Player( i - 1) ) == PLAYER_SLOT_STATE_PLAYING then
				call moneyst( udg_hero[i], ( udg_Boss_LvL - 1 ) * GOLD_GAIN_PER_BOSS_LEVEL )
			endif
			set i = i + 1
		endloop
	endfunction
	
	//===============================================================
	/*private function OnBattleStart_Extra_Condition takes nothing returns boolean
	    return ExtraArenaGeneral_IsArenaActive()
	endfunction

	private function OnBattleStart_Extra takes nothing returns nothing
		call Money_AddMoneyGainMultiplierGlobal(-MONEY_GAIN_MULTIPLIER)
		//call BJDebugMsg("Multiplier -")
		set isMoneyBonusDisabled = true
	endfunction*/
	
	/*private function OnBattleEnd_Extra_Condition takes nothing returns boolean
	    return //isMoneyBonusDisabled
	endfunction

	private function OnBattleEnd_Extra takes nothing returns nothing
		//call Money_AddMoneyGainMultiplierGlobal(MONEY_GAIN_MULTIPLIER)
		//call BJDebugMsg("Multiplier +")
		//set isMoneyBonusDisabled = false
	endfunction*/
	
	//===============================================================
	private function condition takes nothing returns boolean
	    return isActive == false and isEnabledToActivate
	endfunction

	private function action takes nothing returns nothing
		call Multiboard_MultiSetValue( udg_multi, 2, 3, Difficulty_GetName() + " (DT)" )
        call IconFrame( "DT", BlzGetAbilityIcon(ABILITY_USED), BlzGetAbilityTooltip(ABILITY_USED, 0), BlzGetAbilityExtendedTooltip(ABILITY_USED, 0) )
        call CombatTimer_AddBattleTime(ADDITIONAL_BATTLE_TIME, true)
        call SaveLoadStartLib_AddExtraExp(EXPERIENCE_BONUS_PERC)
        //call Money_AddMoneyGainMultiplierGlobal(MONEY_GAIN_MULTIPLIER)
        //call EnableTrigger(Trigger_Start_Extra)
	    //call EnableTrigger(Trigger_End_Extra)
	    call EnableTrigger(Trigger_End_Boss)
	    call EnableTrigger(Trigger_OnBossDeath)
	    set isActive = true
	endfunction
	
	//===============================================================
	private function OnModStateChanged_Condition takes nothing returns boolean
	    return ModesFrame_IsExtraModeCorrect(BUTTON_INDEX)
	endfunction
	
	private function OnModStateChanged takes nothing returns nothing 
        set isEnabledToActivate = isEnabledToActivate == false
        call ModesFrame_ExtraModeChangeIcon(BUTTON_INDEX, "Double Trouble", isEnabledToActivate)
	endfunction

	//===============================================================
	private function init takes nothing returns nothing
	    call OnModsAwake.AddListener(function action, function condition)
	    call ModStateChanged.AddListener(function OnModStateChanged, function OnModStateChanged_Condition )
	    
	    /*set Trigger_Start_Extra = BattleStartGlobal.AddListener(function OnBattleStart_Extra, function OnBattleStart_Extra_Condition)
	    call DisableTrigger(Trigger_Start_Extra)
	    
	    set Trigger_End_Extra = BattleEndGlobal.AddListener(function OnBattleEnd_Extra, function OnBattleEnd_Extra_Condition)
	    call DisableTrigger(Trigger_End_Extra)*/
	    
	    set Trigger_End_Boss = BattleEndGlobal.AddListener(function OnBattleEnd_Boss, function OnBattleEnd_Boss_Condition)
	    call DisableTrigger(Trigger_End_Boss)
	    
	    set Trigger_OnBossDeath = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function OnBossDeath, function OnBossDeath_Condition )
	    call DisableTrigger(Trigger_OnBossDeath)
	endfunction

endscope