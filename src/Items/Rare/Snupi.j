scope Snupi initializer init

	globals
		private constant integer ABILITY_ID = 'A1G5'
		
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl"
		
		private constant integer PET_ID = 'n03X'
		
		private constant integer PET_SUMMON_RANGE = 200
		
		private unit tempUnit = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function PetSummon takes unit caster returns unit
		local real casterFacing = GetUnitFacing(caster)
		local location casterLoc = GetUnitLoc(caster)
		local location petSpawn = PolarProjectionBJ(casterLoc, PET_SUMMON_RANGE, casterFacing)
		
		set tempUnit = CreateUnitAtLoc( GetOwningPlayer(caster), PET_ID, petSpawn, casterFacing)
		call DestroyEffect( AddSpecialEffectTarget( ANIMATION, tempUnit, "origin" ) )
		call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "snupi" ), tempUnit )
		
	    call BlzSetUnitMaxHP( tempUnit, BlzGetUnitMaxHP(caster) )
	    call BlzSetUnitBaseDamage( tempUnit, BlzGetUnitBaseDamage(caster, 0), 0 )
		
		call SetUnitState( tempUnit, UNIT_STATE_LIFE, GetUnitState( caster, UNIT_STATE_LIFE) )
	    
	    call RemoveLocation(casterLoc)
	    call RemoveLocation(petSpawn)
	    set casterLoc = null
	    set petSpawn = null
	    return tempUnit
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit pet
	    
	    if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	
	    set pet = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "snupi" ) )
	    
	    if pet != null then
		    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( pet ), GetUnitY( pet ) ) )
	        call RemoveUnit( pet )
	    endif
	        
        set pet = PetSummon(caster)
        call SetUnitAnimation( pet, "spell slam" )
    	call QueueUnitAnimation( pet, "stand" )
	    
	    set caster = null
	    set pet = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope