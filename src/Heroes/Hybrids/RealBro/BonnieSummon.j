scope BonnieSummon initializer init

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == 'A1EW'
	endfunction
	
	function BunnyAddAbilities takes unit caster, unit bunny, integer whichAbility returns nothing
	    local integer lvlf
	    local player p = GetOwningPlayer(caster)
	    
	    if whichAbility == 1 then
	        call UnitAddAbility(bunny, 'A1BA')
	        set lvlf = IMaxBJ(1,GetUnitAbilityLevel(caster, 'A1B7'))
	        call SaveInteger( udg_hash, GetHandleId( bunny ), StringHash( "rlbaq" ), lvlf )
	        //if GetLocalPlayer() == p then
	            call BlzSetAbilityExtendedTooltip( 'A1BA', words( bunny, BlzGetAbilityExtendedTooltip('A1BA', 0), "|cffbe81f7", "|r", I2S(120 + ( 60 * lvlf )) ), 0 )
	            call BlzSetAbilityExtendedTooltip( 'A1BA', words( bunny, BlzGetAbilityExtendedTooltip('A1BA', 0), "|cffbe81f8", "|r", I2S(30 + ( 10 * lvlf )) ), 0 )
	        //endif
	    elseif whichAbility == 2 then
	        call UnitAddAbility(bunny, 'A1B9')
	        set lvlf = IMaxBJ(1,GetUnitAbilityLevel(caster, 'A1BF'))
	        call SaveInteger( udg_hash, GetHandleId( bunny ), StringHash( "rlbaw" ), lvlf )
	        //if GetLocalPlayer() == p then
	            call BlzSetAbilityExtendedTooltip( 'A1B9', words( bunny, BlzGetAbilityExtendedTooltip('A1B9', 0), "|cffbe81f7", "|r", I2S(14 + ( 8 * lvlf )) ), 0 )
	        //endif
	    elseif whichAbility == 3 then
	        call UnitAddAbility(bunny, 'A1BB')
	        set lvlf = IMaxBJ(1,GetUnitAbilityLevel(caster, 'A1BG'))
	        call SaveInteger( udg_hash, GetHandleId( bunny ), StringHash( "rlbae" ), lvlf )
	        //if GetLocalPlayer() == p then
	            call BlzSetAbilityExtendedTooltip( 'A1BB', words( bunny, BlzGetAbilityExtendedTooltip('A1BB', 0), "|cffbe81f7", "|r", I2S(150 + ( 50 * lvlf )) ), 0 )
	        //endif
	    elseif whichAbility == 4 then
	        call UnitAddAbility(bunny, 'A1BC')
	        set lvlf = IMaxBJ(1,GetUnitAbilityLevel(caster, 'A1BH'))
	        call SaveInteger( udg_hash, GetHandleId( bunny ), StringHash( "rlbar" ), lvlf )
	        //if GetLocalPlayer() == p then
	            call BlzSetAbilityExtendedTooltip( 'A1BC', words( bunny, BlzGetAbilityExtendedTooltip('A1BC', 0), "|cffffffff", "|r", R2SW( 0.5 + ( 0.5 * lvlf), 1, 2 ) ), 0 )
	        //endif
	    endif
	    
	    set p = null
	    set caster = null
	    set bunny = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local unit caster
	    local unit oldpet
	    local integer chance
	    local location petSpawn
	    local real casterFacing 
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName('A1EW'), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	
	    set oldpet = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "rlbq" ) )
	    if GetUnitState( oldpet, UNIT_STATE_LIFE) > 0.405 then
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetUnitX( oldpet ), GetUnitY( oldpet ) ) )
	        call RemoveUnit( oldpet )
	    endif
	    
	    set casterFacing = GetUnitFacing(caster)
	    set petSpawn = PolarProjectionBJ(GetUnitLoc(caster), 200, casterFacing)
	    
	    set bj_lastCreatedUnit = CreateUnitAtLoc( GetOwningPlayer(caster), 'n030', petSpawn, casterFacing)
		//set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'n030', GetUnitX( caster ) + GetRandomReal( -200, 200 ), GetUnitY( caster ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )
	
	    call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "rlbq" ), bj_lastCreatedUnit )
	    call SaveUnitHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "rlbqac" ), caster )
	    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", bj_lastCreatedUnit, "origin" ) )
	
	    if GetUnitAbilityLevel( caster, 'A1B7') > 0 then
	        call BunnyAddAbilities(caster, bj_lastCreatedUnit, 1)
	    endif
	    
	    if GetUnitAbilityLevel( caster, 'A1BF') > 0 then
	        call BunnyAddAbilities(caster, bj_lastCreatedUnit, 2)
	    endif
	    
	    if GetUnitAbilityLevel( caster, 'A1BG') > 0 then
	        call BunnyAddAbilities(caster, bj_lastCreatedUnit, 3)
	    endif
	    
	    if GetUnitAbilityLevel( caster, 'A1BH') > 0 then
	        call BunnyAddAbilities(caster, bj_lastCreatedUnit, 4)
	    endif
	    
	    set petSpawn = null
	    set caster = null
	    set oldpet = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	    set trig = null
	endfunction
	
endscope