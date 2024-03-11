scope PieceOfCake initializer init

	globals
		private constant integer ITEM_ID = 'I0DH'
		private constant integer ATTACK_GAIN = 2
		
		private integer array AttackGain[5]
		
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
	endglobals
	
	private function action takes nothing returns nothing
		local unit caster = PotionUsed.GetDataUnit("caster")
	    local integer index = GetUnitUserData(caster)
	
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
	    call BlzSetUnitBaseDamage( caster, BlzGetUnitBaseDamage(caster, 0) + ATTACK_GAIN, 0 )
	    set AttackGain[index] = AttackGain[index] + ATTACK_GAIN
		
		set caster = null
	endfunction
	
	private function DeleteBonus takes nothing returns nothing
		local integer index = GetUnitUserData(Event_BetweenUnit_Hero)
		
		if AttackGain[index] > 0 then
			call BlzSetUnitBaseDamage( Event_BetweenUnit_Hero, BlzGetUnitBaseDamage(Event_BetweenUnit_Hero, 0) - AttackGain[index], 0 )
	    	set AttackGain[index] = 0
		endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, PotionUsed, function action, null)
		
		call CreateEventTrigger( "Event_BetweenUnit", function DeleteBonus, null )
	endfunction

endscope