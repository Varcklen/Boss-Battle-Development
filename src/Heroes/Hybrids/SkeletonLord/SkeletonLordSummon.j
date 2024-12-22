library SkeletonLordSummon requires SpellPower

	globals
		private constant integer SUMMON_ID = 'u013'
	
		private constant integer LIFE_TIME = 15
		private constant string ANIMATION = "war3mapImported\\SoulRitual.mdx"
	endglobals

	private function GetHP takes unit summon, integer lvl returns integer
		return BlzGetUnitMaxHP(summon) + ( (lvl-1) * 60 )
	endfunction
	
	private function GetAT takes unit summon, integer lvl returns integer
		return BlzGetUnitBaseDamage(summon, 0) + ( (lvl-1) * 3 )
	endfunction

	private function Spawn takes unit caster, real x, real y, real facing returns nothing
		local integer lvl
	    local real size
	    local real duration
	    local unit summon
	    
	    set lvl = IMaxBJ(1, GetUnitAbilityLevel( caster, 'A0CK'))
	    set size = 0.75+(0.05*lvl)
	    set duration = LIFE_TIME * GetUnitSpellPower( caster )
	    
	    set summon = CreateUnit( GetOwningPlayer( caster ), SUMMON_ID, x, y, facing )
	    call SetUnitAnimation( summon, "birth" )
	    call QueueUnitAnimation( summon, "stand" )
	    call UnitApplyTimedLife( summon, 'BTLF', duration )
	    call DestroyEffect(AddSpecialEffectTarget( ANIMATION, summon, "origin"))
	    
	    call BlzSetUnitMaxHP( summon, GetHP(summon, lvl) )
	    call BlzSetUnitBaseDamage( summon, GetAT(summon, lvl), 0 )
	    call SetUnitState( summon, UNIT_STATE_LIFE, GetUnitState( summon, UNIT_STATE_MAX_LIFE) )
	    call SetUnitScale( summon, size, size, size )
	    
	    set summon = null
    endfunction
    
	function skeletsp takes unit caster, unit target returns nothing
	    call Spawn(caster, GetUnitX( target ), GetUnitY( target ), GetRandomReal( 0, 360 ))
	endfunction
	
	function skeletsploc takes unit caster, location summonLoc, real facing returns nothing
	    call Spawn(caster, GetLocationX( summonLoc ), GetLocationY( summonLoc ), facing )
	endfunction

endlibrary