scope InfernalDamage initializer init

	globals
	    //private constant real ATTACK_MODIFIER = 0.4
		//private constant real ATTACK_MODIFIER_UPGRADED = 0.8
		
		//private constant real AREA_AFFECTED = 500
		
		private constant integer ABILITY_ID = 'A1A6'
		private constant integer MAIN_ABILITY_ID = 'A1A5'
		
		//private boolean LoopBrake = false
	endglobals
	
	private function condition takes nothing returns boolean
		//return (GetUnitAbilityLevel( udg_DamageEventTarget, ABILITY_ID) > 1)
		return (GetUnitAbilityLevel( AfterDamageSysTarget, ABILITY_ID) > 1)
	endfunction
	
	private function reset_condition takes nothing returns boolean
		return GetUnitAbilityLevel( udg_FightStart_Unit, MAIN_ABILITY_ID) > 0
	endfunction
	
	private function action takes nothing returns nothing
		//local unit u = udg_DamageEventTarget
		//local real dmg = udg_DamageEventAmount
		local unit u = AfterDamageSysTarget
		local real dmg = AfterDamageSysAmount
    	local integer id = GetHandleId(u)
    	local real dmgdone = LoadReal( udg_hash, id, StringHash( "infe" ) )
    	local real dmghp = LoadReal( udg_hash, id, StringHash( "infen" ) )

   		set dmgdone = dmgdone + dmg
	    if dmgdone >= dmghp then
	        set dmgdone = 0
			call platest(u, -1 )
			set bj_lastCreatedItem = CreateItem('I0G8', GetUnitX( u ) + GetRandomReal( -300, 300 ), GetUnitY( u ) + GetRandomReal( -300, 300 ))
			call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )
		endif
    
    	call SaveReal( udg_hash, id, StringHash( "infe" ), dmgdone )
    	set u = null
	endfunction

	private function reset takes nothing returns nothing
		local unit u = udg_FightStart_Unit
    	local integer id = GetHandleId(u)
    	//local real i = LoadReal( udg_hash, id, StringHash( "infe" ) )
    	//call BJDebugMsg( "|c00FFFF00Found: " + R2S(i))
		call SaveReal( udg_hash, id, StringHash( "infe" ), 0. )
    	set u = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
        //call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
        local trigger trig = CreateTrigger()
        call CreateEventTrigger( "AfterDamageSysEvent", function action, function condition )
		set trig = null
        call CreateEventTrigger( "udg_FightStart_Real", function reset, function reset_condition )
    endfunction

endscope