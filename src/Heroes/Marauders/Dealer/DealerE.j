scope DealerE initializer init

    globals
        private constant integer ID_ABILITY = 'A188'
        
        private constant integer CHANCE_FIRST_LEVEL = 1
        private constant integer CHANCE_LEVEL_BONUS = 4
        
        private constant integer BANANA_SPAWN_SCATTER_ALTERNATIVE = 335
        
        private constant string ANIMATION = "war3mapImported\\TimeUpheaval.mdx"
        
		trigger trg_DealerE = null
    endglobals

    function Trig_DealerE_Conditions takes nothing returns boolean
        if IsUnitHasAbility( GetSpellAbilityUnit(), ID_ABILITY) == false then
            return false
        elseif combat(GetSpellAbilityUnit(), false, 0) == false then
            return false
        elseif LuckChance( GetSpellAbilityUnit(), CHANCE_FIRST_LEVEL+(CHANCE_LEVEL_BONUS*GetUnitAbilityLevel( GetSpellAbilityUnit(), ID_ABILITY)) ) == false then
            return false
        endif
        return true
    endfunction

    private function Alternative takes unit caster returns nothing
    	local real angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
    	local real dist =  GetRandomReal( 0, BANANA_SPAWN_SCATTER_ALTERNATIVE )
        local real x = GetUnitX( caster ) + dist * Cos( angle )
        local real y = GetUnitY( caster ) + dist * Sin( angle )
        call SpawnBanana( caster, x, y )
        
        set caster = null 
    endfunction
    
    private function Main takes unit caster, unit target returns nothing 
    
        call PlaySpecialEffect(ANIMATION, caster)
        set udg_CastLogic = true
        set udg_Caster = caster
        set udg_Target = target

        set udg_Level = 5
        set udg_Time = 20
        call TriggerExecute( udg_TrigNow )
        
        set caster = null 
        set target = null
    endfunction

    function Trig_DealerE_Actions takes nothing returns nothing
        local unit hero = GetSpellAbilityUnit()
        
        if Aspects_IsHeroAspectActive( hero, ASPECT_02 ) then
            call Alternative( hero )
        else
            call Main( hero, GetSpellTargetUnit() )
        endif
        
        set hero = null
    endfunction

    //===========================================================================
	private function init takes nothing returns nothing
        set trg_DealerE = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg_DealerE, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_DealerE, Condition( function Trig_DealerE_Conditions ) )
        call TriggerAddAction( trg_DealerE, function Trig_DealerE_Actions )
    endfunction

endscope