scope CurseSupport initializer init

	globals
		private trigger Trigger = null
		private constant integer UNIT_ID = 'u00I'
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl"
		
		private constant integer HEALTH_START = 200
		private constant integer HEALTH_LEVEL = 100
		
		private constant integer DAMAGE_START = 5
		private constant integer DAMAGE_LEVEL = 5
		
		private constant real SIZE_INITIAL = 1.1
		private constant real SIZE_INCREASE = 0.05
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[1]
	endfunction
	
	private function Summon takes unit boss returns nothing
		local unit newUnit
		local real scale
		
		set newUnit = CreateUnit(GetOwningPlayer(boss), UNIT_ID, GetUnitX(boss), GetUnitY(boss), GetUnitFacing(boss))
        call DestroyEffect(AddSpecialEffectTarget( ANIMATION, newUnit, "origin"))
        
        call BlzSetUnitBaseDamage( newUnit, DAMAGE_START + (udg_Boss_LvL - 1) * DAMAGE_LEVEL, 0 ) 
        call BlzSetUnitMaxHP( newUnit, HEALTH_START + (udg_Boss_LvL - 1) * HEALTH_LEVEL )
		call SetUnitState( newUnit, UNIT_STATE_LIFE, GetUnitState( newUnit, UNIT_STATE_MAX_LIFE ) )
		
		set scale = SIZE_INITIAL + udg_Boss_LvL * SIZE_INCREASE
		call SetUnitScale( newUnit, scale, scale, scale )
        
        set newUnit = null
	endfunction
	
	private function end takes nothing returns nothing
	    local unit boss = MainBoss

	    if IsUnitAlive(boss) then
		    call Summon(boss)
	    endif

	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		//call SaveUnitHandle( udg_hash, 1, StringHash( "mod_support" ), MainBoss )
        call TimerStart( CreateTimer(), 1, false, function end )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		call ConditionalTriggerExecute( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope