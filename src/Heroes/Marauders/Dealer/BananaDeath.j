scope BananaDeath initializer init

    globals
        private constant integer ID_BANANA = 'o01B'
        
        private constant real GOLD_TO_HERO_ALTERNATIVE_03 = 0.55
        private constant real GOLD_TO_OTHERS_ALTERNATIVE_03 = 0.25
        
        private constant real SPELL_POWER_WEIGHT = 0.5
        
        private constant integer HEAL = 100
        private constant integer GOLD = 20
        
		trigger trg_BananaDeath = null
    endglobals

    function Trig_BananaDeath_Conditions takes nothing returns boolean
        return GetUnitTypeId(GetDyingUnit()) == ID_BANANA
    endfunction
    
    private function BananaBonus takes unit hero, unit target, real heal, real gold returns nothing 
    	local real spellPower
        call healst( hero, target, heal )
        if combat( target, false, 0 ) and udg_fightmod[3] == false and gold > 0 then
        	set spellPower = GetUnitSpellPowerWeight(hero, SPELL_POWER_WEIGHT)
            call moneyst( target, R2I( gold * spellPower) )
        endif
    endfunction
        
    private function Alternative_01 takes unit hero returns nothing 
        local integer i
        
        set i = 1
        loop
            exitwhen i > PLAYERS_LIMIT
            if unitst(udg_hero[i], hero, TARGET_ALLY) then
                call BananaBonus(hero, udg_hero[i], HEAL, 0)
            endif
            set i = i + 1
        endloop
        
        set hero = null
    endfunction
    
    private function Alternative_03 takes unit hero, unit killer returns nothing 
        local integer goldToHero = R2I(GOLD * GOLD_TO_HERO_ALTERNATIVE_03)
        local integer goldToOthers = R2I(GOLD * GOLD_TO_OTHERS_ALTERNATIVE_03)
        local integer i = 0
    
        if hero != killer and IsUnitType( killer, UNIT_TYPE_HERO) and unitst(killer, hero, TARGET_ALLY) and killer != null then
            set i = 1
            loop
                exitwhen i > PLAYERS_LIMIT
                if hero == udg_hero[i] then
                    call BananaBonus(hero, hero, HEAL, goldToHero)
                elseif unitst(udg_hero[i], hero, TARGET_ALLY) then
                    call BananaBonus(hero, udg_hero[i], HEAL, goldToOthers)
                endif
                set i = i + 1
            endloop
        elseif IsUnitAlive(hero) then
            call BananaBonus(hero, hero, HEAL, goldToHero)
        endif
    
        set hero = null
        set killer = null
    endfunction
    
    private function Main takes unit hero returns nothing 
        if IsUnitAlive(hero) then
            call BananaBonus(hero, hero, HEAL, GOLD)
        endif
        
        set hero = null
    endfunction

    function Trig_BananaDeath_Actions takes nothing returns nothing
        local unit ownerHero = udg_hero[GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1]
        
        if Aspects_IsHeroAspectActive( ownerHero, ASPECT_01 ) then
            call Alternative_01( ownerHero )
        elseif Aspects_IsHeroAspectActive( ownerHero, ASPECT_03 ) then
            call Alternative_03( ownerHero, GetKillingUnit() )
        else
            call Main( ownerHero )
        endif

        set ownerHero = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_BananaDeath = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_BananaDeath, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( trg_BananaDeath, Condition( function Trig_BananaDeath_Conditions ) )
        call TriggerAddAction( trg_BananaDeath, function Trig_BananaDeath_Actions )
    endfunction

endscope
