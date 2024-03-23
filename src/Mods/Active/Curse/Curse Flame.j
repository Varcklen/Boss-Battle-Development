scope CurseFlame initializer init

	globals
		private trigger Trigger = null
		
		private constant integer DAMAGE = 25 
		private constant integer RANGE = 250
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO)
	endfunction
	
	private function action takes nothing returns nothing
		local group g = CreateGroup()
	    local unit u
	    
	    call DestroyEffect( AddSpecialEffectTarget(ANIMATION, GetSpellAbilityUnit(), "origin" ) )
	    call GroupEnumUnitsInRange( g, GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ), RANGE, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, GetSpellAbilityUnit(), "ally" ) and u != GetSpellAbilityUnit() then
	            call UnitDamageTarget( GetSpellAbilityUnit(), u, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
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