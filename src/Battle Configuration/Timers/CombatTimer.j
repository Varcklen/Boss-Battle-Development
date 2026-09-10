library CombatTimer initializer init requires DeathLib

	globals
		private timer Timer = CreateTimer()
		private timerdialog Dialog = CreateTimerDialog(Timer)
		
		private constant string DIALOG_DESCRIPTION = "Battle limit:"
		
		private boolean FatigueEnabled = false
		private real HealReduction = 0
		private real Damage = 0
		
		private constant real EXTRA_DAMAGE_PER_TICK = 0.02
		private constant real HEAL_REDUCTION_ADD = 0.02	
		private constant integer TICK = 4
		
		private real BossBattleTime = 180
		private real ExtraBattleTime = 300
	endglobals
	
	public function AddBattleTime takes integer timeToAdd, boolean isBossBattle returns nothing
		if isBossBattle then
			set BossBattleTime = BossBattleTime + timeToAdd
		else
			set ExtraBattleTime = ExtraBattleTime + timeToAdd
		endif
	endfunction
	
	private function BossDamageCast takes nothing returns nothing
	    local integer i
	    local unit hero
	    local real hpToLose

	    if udg_fightmod[0] == false or udg_fightmod[3] then
	    	call DestroyTimer( GetExpiredTimer() )
	    else
        	set Damage = Damage + EXTRA_DAMAGE_PER_TICK

            set HealReduction = RMinBJ(HealReduction + HEAL_REDUCTION_ADD, 1)
            
            set i = 1
            loop
                exitwhen i > 4
                set hero = udg_hero[i]
                if IsUnitAlive(hero) then
                	set hpToLose = GetUnitState( hero, UNIT_STATE_MAX_LIFE) * Damage
                    call SetUnitState( hero, UNIT_STATE_LIFE, RMaxBJ( 0, GetUnitState( hero, UNIT_STATE_LIFE) - hpToLose ) )
                    call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX( hero ), GetUnitY( hero ) ) )
                endif
                set i = i + 1
            endloop
	    endif
	    
	    set hero = null
	endfunction
	
	private function BossDamageTimer takes nothing returns nothing
	    set FatigueEnabled = true
	    set Damage = 0
	    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, "|cffffcc00Warning!|r Battle limit exceeded! The Health and Healing Efficiency of heroes gradually decreases." )
	    call StartSound(gg_snd_Warning)
	    
	    call TimerDialogDisplay( Dialog, false )
	    
	    call TimerStart( CreateTimer(), TICK, true, function BossDamageCast )
	endfunction
	
	public function Launch takes nothing returns nothing
		local real time
		
		if udg_fightmod[1] then
			set time = BossBattleTime
		else
			set time = ExtraBattleTime
		endif
	
		call TimerStart( Timer, time, false, function BossDamageTimer )
        call TimerDialogSetTitle(Dialog, DIALOG_DESCRIPTION )
        call TimerDialogDisplay(Dialog, true)
	endfunction
	
	//===========================================================================
	private function OnFightEnd takes nothing returns nothing
		set FatigueEnabled = false
		set HealReduction = 0
		call PauseTimer(Timer)
		call TimerDialogDisplay( Dialog, false )
	endfunction
	
	//===========================================================================
	private function OnHeal_Condition takes nothing returns boolean
		return FatigueEnabled
	endfunction
	
	private function OnHeal takes nothing returns nothing
		local unit caster = BeforeHeal.GetDataUnit("caster")
		local real healToLose = HealReduction * BeforeHeal.GetDataReal("static_heal")
		local real heal = BeforeHeal.GetDataReal("heal")
		
		call BeforeHeal.SetDataReal("heal", heal - healToLose)
		
		set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call BattleEndGlobal.AddListener(function OnFightEnd, null)
		call BeforeHeal.AddListener(function OnHeal, function OnHeal_Condition)
	endfunction

endlibrary