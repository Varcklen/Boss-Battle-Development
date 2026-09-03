scope DifficultyThree initializer init

	globals
		private integer DIFFICULTY_REQUIRED = 3
		private boolean isActive = false
		
		private constant real POWER_BOOST_START = 0.03
		private constant real POWER_BOOST_TIMER = 0.01
		private constant integer TIME_TO_UPGRADE = 90
		
		private string ICON
		private string NAME 
		private string DESCRIPTION 
		
		public trigger Trigger_Start = null
		public trigger Trigger_End = null
		
		private timer Timer = null
		
		private integer CurrentBonus = 0
	endglobals
	
	private function OnBattleStart_Condition takes nothing returns boolean
	    return udg_fightmod[3] == false and ExtraArenaGeneral_IsPvPActive() == false
	endfunction
	
	private function PowerUp takes real powerBoost returns nothing
		local string text
		
		call EnemyPower_AddAtBonusAdditive(powerBoost)
		call EnemyPower_AddHpBonusAdditive(powerBoost)
        call SpellPower_AddBossSpellPower(powerBoost)
        
        set CurrentBonus = CurrentBonus + R2I(powerBoost*100)
        
        set text = "|n|cffffcc00Current Power Boost|r: +" + I2S(CurrentBonus) + "%."
        call IconFrame( "HardMode", ICON, NAME, DESCRIPTION + text )
	endfunction
	
	private function TimerEnd takes nothing returns nothing
		call PowerUp(POWER_BOOST_TIMER)
	endfunction

	private function OnBattleStart takes nothing returns nothing
		call PowerUp(POWER_BOOST_START)
        call TimerStart( Timer, TIME_TO_UPGRADE, true, null )
	endfunction
	
	private function OnBattleEnd_Condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function OnBattleEnd takes nothing returns nothing
		call PauseTimer( Timer )
	endfunction
	
	//===============================================================
	private function condition takes nothing returns boolean
	    return isActive == false and Difficulty_GetIndex() >= DIFFICULTY_REQUIRED
	endfunction

	private function action takes nothing returns nothing
		local integer difficultyIcon = udg_DB_ModesFrame_Difficulty[Difficulty_GetIndex()]
	    call EnableTrigger(Trigger_Start)
	    call EnableTrigger(Trigger_End)
	    set isActive = true
	    
	    set ICON = BlzGetAbilityIcon(difficultyIcon)
		set NAME = BlzGetAbilityTooltip(difficultyIcon, 0)
		set DESCRIPTION = IconFrameLib_GetDescription("HardMode")
	endfunction

	private function init takes nothing returns nothing
		local trigger trig 
		
		set Timer = CreateTimer()
		
	    call OnModsAwake.AddListener(function action, function condition)
	    
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