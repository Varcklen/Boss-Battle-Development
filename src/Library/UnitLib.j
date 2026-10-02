library UnitLib requires DeathLib

	function IsUnitHasAbility takes unit caster, integer myBuff returns boolean
        local boolean isWork = GetUnitAbilityLevel( caster, myBuff) > 0
        set caster = null
        return isWork
    endfunction
    
    function GetHeroNumber takes integer heroId returns integer
        local integer i = 1
        loop
            exitwhen i > udg_Database_InfoNumberHeroes
            if udg_Database_Hero[i] == heroId then
                return i
            endif
            set i = i + 1
        endloop
        return 0
    endfunction

	//Checks if a minion can be affected by a buff. The Sludge (minion) from Split should not receive buffs.
	function IsPermaBuffAffected takes unit unitToCheck returns boolean
        
        if GetUnitAbilityLevel( unitToCheck, 'A1EN') > 0 then
        	return false
        endif
        return true
    endfunction
    
    //Checks whether a unit can be affected by boss effects directed against minions.
    function IsMinionImmune takes unit unitToCheck returns boolean
        
        if GetUnitAbilityLevel( unitToCheck, 'A1EG') > 0 then
        	return true
        endif
        return false
    endfunction
    
    function IsMinion takes unit unitToCheck returns boolean
    	if IsUnitType( unitToCheck, UNIT_TYPE_HERO) then
    		return false
		elseif IsUnitType( unitToCheck, UNIT_TYPE_ANCIENT) then
    		return false
		endif
        return true
    endfunction
    
    function IsDummy takes unit unitToCheck returns boolean
    	return GetUnitAbilityLevel(unitToCheck, 'A1FY' ) > 0
    endfunction
    
    function IsBoss takes unit unitToCheck returns boolean
		if IsUnitType( unitToCheck, UNIT_TYPE_ANCIENT) then
    		return true
		endif
        return false
    endfunction
    
    function IsHero takes unit unitToCheck returns boolean
		if IsUnitType( unitToCheck, UNIT_TYPE_HERO) then
    		return true
		endif
        return false
    endfunction
    
    function unitst takes unit target, unit caster, string str returns boolean
    	if IsUnitDead(target) then
    		return false
    	endif
    	if IsDummy(target) then
    		return false
    	endif
    	if GetOwningPlayer( target ) == Player( PLAYER_NEUTRAL_PASSIVE ) then
    		return false
    	endif
    
        if str == "enemy" and IsUnitEnemy( target, GetOwningPlayer( caster ) ) and BlzIsUnitInvulnerable(target) == false then
            return true
        elseif str == "ally" and IsUnitAlly( target, GetOwningPlayer( caster ) ) then
            return true
        elseif str == "all" and BlzIsUnitInvulnerable(target) == false then
            return true
        endif
        return false
    endfunction

    //=========================================================
    globals
        private constant integer GLOW_NORMAL = 'A0D8'
        private constant integer GLOW_SMALL = 'A0UI'
        private constant integer GLOW_BIG = 'A062'
    endglobals
    
    private function Refresh takes unit whichUnit, integer skinId returns nothing
        call UnitRemoveAbility(whichUnit, skinId)
        call UnitAddAbility(whichUnit, skinId)
        set whichUnit = null
    endfunction

    function SetUnitSkin takes unit whichUnit, integer skinId returns nothing
        call BlzSetUnitSkin( whichUnit, skinId )
            
        if IsUnitHasAbility(whichUnit, GLOW_NORMAL) then
            call Refresh(whichUnit, GLOW_NORMAL)
        elseif IsUnitHasAbility(whichUnit, GLOW_SMALL) then
            call Refresh(whichUnit, GLOW_SMALL)
        elseif IsUnitHasAbility(whichUnit, GLOW_BIG) then
            call Refresh(whichUnit, GLOW_BIG)
        endif
        
        set whichUnit = null
    endfunction
    
    //=========================================================
    globals
        unit CreateUnitCopy_Original
        unit CreateUnitCopy_Copy
        real CreateUnitCopy_Real
    endglobals

    function CreateUnitCopy takes unit original, real x, real y, real face returns unit
        local unit copy = CreateUnit( GetOwningPlayer( original ), GetUnitTypeId( original ), x, y, face )
        
        call BlzSetUnitMaxHP( copy, BlzGetUnitMaxHP(original) )
        if GetUnitState( original, UNIT_STATE_LIFE) > 0.405 then
            call SetUnitLifePercentBJ( copy, GetUnitLifePercent(original) )
        else
            call SetUnitLifePercentBJ( copy, 100 )
        endif
        call BlzSetUnitBaseDamage( copy, BlzGetUnitBaseDamage(original, 0), 0 )
        call BlzSetUnitArmor( copy, BlzGetUnitArmor(original) )
        call SetUnitMoveSpeed( copy, GetUnitDefaultMoveSpeed(original) )
        
        set CreateUnitCopy_Original = original
        set CreateUnitCopy_Copy = copy
        set CreateUnitCopy_Real = 0.00
        set CreateUnitCopy_Real = 1.00
        set CreateUnitCopy_Real = 0.00
        
        set udg_Temp_Unit = copy
        set copy = null
        set original = null
        return udg_Temp_Unit
    endfunction
    
    //=========================================================
    function UnitTakeDamage takes unit dealer, unit target, real damage, damagetype damageType returns nothing
        local attacktype attackType = ATTACK_TYPE_HERO
        
        if dealer == null or target == null then
            set attackType = null
            set dealer = null
            set target = null
            return
        endif
        
        if damageType == DAMAGE_TYPE_MAGIC then
            set attackType = ATTACK_TYPE_NORMAL
        endif

        call UnitDamageTarget( dealer, target, damage, true, false, attackType, damageType, WEAPON_TYPE_WHOKNOWS)
            
        set attackType = null
        set dealer = null
        set target = null
    endfunction

endlibrary