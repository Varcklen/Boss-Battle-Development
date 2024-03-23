scope CurseMitrust initializer init

	globals
		private trigger Trigger = null
		
		constant integer MISTRUST_MANABURN = 5
        constant integer MISTRUST_AREA = 250
        
        constant string MISTRUST_ANIMATION = "Abilities\\Spells\\Undead\\DeathPact\\DeathPactCaster.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO)
	endfunction
	
    private function action takes nothing returns nothing
        local group g = CreateGroup()
        local unit u
        local unit caster = GetSpellAbilityUnit()

        call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), MISTRUST_AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "ally" ) and u != caster and IsUnitType( u, UNIT_TYPE_HERO) then
                call DestroyEffect( AddSpecialEffectTarget(MISTRUST_ANIMATION, u, "origin" ) )
                call SetUnitState( u, UNIT_STATE_MANA, RMaxBJ(0,GetUnitState( u, UNIT_STATE_MANA) - MISTRUST_MANABURN ))
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyGroup( g )
        set u = null
        set g = null
        set caster = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
        call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_FINISH, function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope