scope ArcanologistQ initializer init

    globals
        private constant integer ID_ABILITY = 'A1HE'
        
        private constant integer MANA_FIRST_LEVEL = 30
        private constant integer MANA_LEVEL_BONUS = 10
        private constant integer SHIELD_FIRST_LEVEL = 80
        private constant integer SHIELD_LEVEL_BONUS = 40
        
        //private constant string ARCANALOGIST_Q_ANIMATION = "Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl"
        
		trigger ArcanologistQ = null
    endglobals

    private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function action takes nothing returns nothing
        local unit caster
        local unit u
        local integer lvl
        local real mana
        local real sh
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, ID_ABILITY)
        endif
        set mana = MANA_FIRST_LEVEL + ( MANA_LEVEL_BONUS * lvl )
        set sh = SHIELD_FIRST_LEVEL + ( SHIELD_LEVEL_BONUS * lvl )
        
        //call DestroyEffect( AddSpecialEffectTarget(ARCANALOGIST_Q_ANIMATION, caster, "origin") )

        call shield( caster, null, sh )
        call manast( caster, null, mana )
        
        set u = randomtarget( caster, 600, TARGET_ENEMY, RT_NOT_PROVOKED, 0, 0 )
        if u != null then
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl", GetUnitX(caster),GetUnitY(caster) ) )
            call taunt( caster, u, 3 )
        endif
        
        set caster = null
        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
		set ArcanologistQ = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope

