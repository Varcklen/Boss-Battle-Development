scope ArcanologistQ initializer init

    globals
        private constant integer ID_ABILITY = 'A1HE'
        
        private constant integer SHIELD_FIRST_LEVEL = 120
        private constant integer SHIELD_LEVEL_BONUS = 40
        
        private constant integer TAUNT_DURATION = 5
        
        private constant string ANIMATION = "Abilities\\Spells\\NightElf\\Taunt\\TauntCaster.mdl"
        
		trigger ArcanologistQ = null
    endglobals

    private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function action takes nothing returns nothing
        local unit caster
        local integer lvl
        local real sh
        local unit target
        
        if CastLogic() then
            set caster = udg_Caster
            set target = udg_Target
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set target = randomtarget( caster, 900, TARGET_ENEMY, RT_NOT_PROVOKED, 0, 0 )
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            if target == null then
	            set caster = null
	            return
	        endif
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, ID_ABILITY)
            set target = GetSpellTargetUnit()
        endif
        set sh = SHIELD_FIRST_LEVEL + SHIELD_LEVEL_BONUS * lvl

        call shield( caster, null, sh )
        
        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX(caster),GetUnitY(caster) ) )
        call taunt( caster, target, timebonus(caster, TAUNT_DURATION) )
        
        set caster = null
        set target = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
		set ArcanologistQ = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope

