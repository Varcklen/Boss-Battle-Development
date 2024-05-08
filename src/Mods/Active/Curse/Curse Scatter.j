scope CurseScatter initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return GetOwningPlayer(GetDyingUnit()) == Player(10) and GetUnitAbilityLevel(GetDyingUnit(), 'A1FY') == 0
	endfunction
	
	private function action takes nothing returns nothing
		//call GroupAoE( GetDyingUnit(), 0, 0, 35, 300, "enemy", "war3mapImported\\ArcaneExplosion.mdx", "" )
		local unit caster = GetDyingUnit()
		local group g = CreateGroup()
    	local unit u

	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Orc\\OrcSmallDeathExplode\\OrcSmallDeathExplode.mdl", GetUnitX(caster), GetUnitY(caster) ) )
	    call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 300, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, caster, "enemy" ) and IsUnitType( u, UNIT_TYPE_HERO) then
	            call UnitDamageTarget( caster, u, 35, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
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
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
		//set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope