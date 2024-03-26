scope Deadflower initializer init

	globals
		private constant integer ITEM_ID = 'I045'
		
		private constant real HEAL_PERC = 0.2
		private constant string ANIMATION = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and (IsUnitAlive(AnyHeroDied.TriggerUnit) or AnyHeroDied.TriggerUnit == AnyHeroDied.TargetUnit)
	endfunction

	private function action takes nothing returns nothing
		local unit caster = AnyHeroDied.GetDataUnit("caster")
		local integer i = 1
		local unit unitHero

        loop
            exitwhen i > PLAYERS_LIMIT
            set unitHero = udg_hero[i]
            if IsUnitAlive(unitHero) then
                call healst( caster, unitHero, GetUnitState(unitHero, UNIT_STATE_MAX_LIFE) * HEAL_PERC )
                call manast( caster, unitHero, GetUnitState(unitHero, UNIT_STATE_MAX_MANA) * HEAL_PERC )
                call DestroyEffect( AddSpecialEffectTarget( ANIMATION, unitHero, "origin") )
            endif
            set i = i + 1
        endloop
        
        set unitHero = null
        set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyHeroDied, function action, function condition, "caster" )
	endfunction

endscope