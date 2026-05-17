scope PowerUpMode initializer init

	globals
		private boolean isActive = false
		private boolean isEnabledToActivate = false
		
		private constant real POWER_BOOST_START = 0.05
		private constant real POWER_BOOST_TIMER = 0.01
		private constant integer TIME_TO_UPGRADE = 60
		
		private string ICON
		private string NAME 
		private string DESCRIPTION 
		
		private trigger Trigger_Start = null
		private trigger Trigger_End = null
		
		private timer Timer = null
		
		private integer CurrentBonus = 0
		
		private constant integer BUTTON_INDEX = 4
		private constant integer EXPERIENCE_BONUS_PERC = 15
	endglobals
	
	private function PowerUp takes real powerBoost returns nothing
		local string text
	
    	call EnemyPower_AddAtBonusAdditive(powerBoost)
		call EnemyPower_AddHpBonusAdditive(powerBoost)
        call SpellPower_AddBossSpellPower(powerBoost)
        
        set CurrentBonus = CurrentBonus + R2I(powerBoost*100)
        
        set text = "|n|cffffcc00Current Power Boost|r: +" + I2S(CurrentBonus) + "%."
        call IconFrame( "Power up", ICON, NAME, DESCRIPTION + text )
	endfunction
	
	private function TimerEnd takes nothing returns nothing
		call PowerUp(POWER_BOOST_TIMER)
	endfunction
	
	private function OnBattleStart_Condition takes nothing returns boolean
	    return udg_fightmod[3] == false and ExtraArenaGeneral_IsPvPActive() == false
	endfunction

	private function OnBattleStart takes nothing returns nothing
		call PowerUp(POWER_BOOST_START)
        call TimerStart( Timer, TIME_TO_UPGRADE, true, null )
	endfunction
	
	private function OnBattleEnd_Condition takes nothing returns boolean
	    return udg_fightmod[3] == false and ExtraArenaGeneral_IsPvPActive() == false
	endfunction

	private function OnBattleEnd takes nothing returns nothing
		call PauseTimer( Timer )
	endfunction
	
	//===============================================================
	private function condition takes nothing returns boolean
	    return isActive == false and isEnabledToActivate
	endfunction

	private function action takes nothing returns nothing
		call IconFrame( "Power up", ICON, NAME, DESCRIPTION )
	    call EnableTrigger(Trigger_Start)
	    call EnableTrigger(Trigger_End)
	    call DisableTrigger(DifficultyThree_Trigger_Start)
	    call DisableTrigger(DifficultyThree_Trigger_End)
	    set isActive = true
	    call SaveLoadStartLib_AddExtraExp(EXPERIENCE_BONUS_PERC)
	endfunction
	
	private function OnModStateChanged_Condition takes nothing returns boolean
	    return ModesFrame_IsExtraModeCorrect(BUTTON_INDEX)
	endfunction
	
	private function OnModStateChanged takes nothing returns nothing 
        set isEnabledToActivate = isEnabledToActivate == false
        call ModesFrame_ExtraModeChangeIcon(BUTTON_INDEX, "Power Up!", isEnabledToActivate)
	endfunction

	private function init takes nothing returns nothing
		local trigger trig 
		
		set ICON = BlzGetAbilityIcon('A09D')
		set NAME = BlzGetAbilityTooltip('A09D', 0)
		set DESCRIPTION = BlzGetAbilityExtendedTooltip('A09D', 0)
		
		set Timer = CreateTimer()
		
	    call OnModsAwake.AddListener(function action, function condition)
	    call ModStateChanged.AddListener(function OnModStateChanged, function OnModStateChanged_Condition )
	    
	    set Trigger_Start = BattleStartGlobal.AddListener(function OnBattleStart, function OnBattleStart_Condition)
	    call DisableTrigger(Trigger_Start)
	    
	    set Trigger_End = BattleEndGlobal.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	    call DisableTrigger(Trigger_End)
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, Timer )
	    call TriggerAddAction( trig, function TimerEnd )
	    set trig = null
	endfunction

endscope