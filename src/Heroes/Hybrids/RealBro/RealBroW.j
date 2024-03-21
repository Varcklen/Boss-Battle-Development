scope ReadBroW initializer init

	globals
		private constant integer ABILITY_ID = 'A1BF'
		
		private constant integer DAMAGE_INITIAL = 55
		private constant integer DAMAGE_PER_LEVEL = 25
		
		private constant integer AREA = 400
		
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl"
		private constant string ANIMATION_DAMAGE = "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl"
		
		trigger trig_RealBroW = null
	endglobals
	
	//call GroupAoE( GetDyingUnit(), null, GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 35, 300, "enemy", "war3mapImported\\ArcaneExplosion.mdx", "" )
	//GroupAoE takes unit caster, unit dummy, real x, real y, real dmg, real area, string who, string strall, string str

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
	endfunction
	
	private function TeleportationEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "real_bro_w_caster" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "real_bro_w_target" ) )
	    local real x = LoadReal( udg_hash, id, StringHash( "real_bro_w_x" ) )
	    local real y = LoadReal( udg_hash, id, StringHash( "real_bro_w_y" ) )
	    local real xCaster = LoadReal( udg_hash, id, StringHash( "real_bro_w_x_caster" ) )
	    local real yCaster = LoadReal( udg_hash, id, StringHash( "real_bro_w_y_caster" ) )
	   	local integer damage = LoadInteger( udg_hash, id, StringHash( "real_bro_w_damage" ) )
	    
	    call SetUnitPosition( caster, x, y )
	    call SetUnitPosition( target, xCaster, yCaster )
	    call GroupAoE( caster, x, y, damage, AREA, "enemy", ANIMATION, ANIMATION_DAMAGE )
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
	    
	    call FlushChildHashtable( udg_hash, id )

	    set caster = null
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit target
	    local integer id
	    local real x 
	    local real y 
	    local real xCaster
	    local real yCaster
	    local integer lvl
	    local integer damage
	
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	        set lvl = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 600, "enemy", "", "", "", "" )
	        set lvl = udg_Level
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
	    endif

	    if udg_fightmod[3] and not( RectContainsUnit(udg_Boss_Rect, target) ) then
	        set caster = null
	        set target = null
	        return
	    endif
	    
	    set x = GetUnitX( target )
	    set y = GetUnitY( target )
	    set xCaster = GetUnitX( caster )
	    set yCaster = GetUnitY( caster )
	    set damage = DAMAGE_INITIAL + (DAMAGE_PER_LEVEL * lvl)
	    
	    call GroupAoE( caster, xCaster, yCaster, damage, AREA, "enemy", ANIMATION, ANIMATION_DAMAGE )
	    
	    set id = GetHandleId( caster )
	    
	    call SaveTimerHandle( udg_hash, id, StringHash( "real_bro_w" ), CreateTimer() )
		set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "real_bro_w" ) ) ) 
		call SaveUnitHandle( udg_hash, id, StringHash( "real_bro_w_caster" ), caster )
		call SaveUnitHandle( udg_hash, id, StringHash( "real_bro_w_target" ), target )
		call SaveInteger( udg_hash, id, StringHash( "real_bro_w_damage" ), damage )
	    call SaveReal( udg_hash, id, StringHash( "real_bro_w_x" ), x )
	    call SaveReal( udg_hash, id, StringHash( "real_bro_w_y" ), y )
	    call SaveReal( udg_hash, id, StringHash( "real_bro_w_x_caster" ), xCaster )
	    call SaveReal( udg_hash, id, StringHash( "real_bro_w_y_caster" ), yCaster )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "real_bro_w" ) ), 0.01, false, function TeleportationEnd )
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set trig_RealBroW = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig_RealBroW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig_RealBroW, Condition( function condition ) )
	    call TriggerAddAction( trig_RealBroW, function action )
	endfunction

endscope