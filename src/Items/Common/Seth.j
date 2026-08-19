scope Seth initializer init 

	globals
		private constant integer ABILITY_ID = 'A1JE'
		private constant integer DAMAGE = 250
		
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
		private constant string ANIMATION_SPAWN = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not(udg_fightmod[3])
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd 
	    local unit caster
	    local unit target
	    local integer itemType
	    local item itemCreated
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	    endif 
	    
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
	    set cyclAEnd = eyest( caster )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	        if ItemManipulation_IsInventoryFull(caster) == false then
	        	call DestroyEffect( AddSpecialEffect( ANIMATION_SPAWN, GetUnitX( caster ), GetUnitY( caster ) ) )
	        	
			    set itemType = DB_SetItems[SET_RING][GetRandomInt( 1, udg_DB_SetItems_Num[SET_RING] ) ]
	            set itemCreated = CreateItem( itemType, GetUnitX(caster), GetUnitY(caster) )
	            call UnitAddItemSwapped( itemCreated, caster )
	            call BlzSetItemExtendedTooltip( itemCreated, "|cffC71585Cursed|r|n" + BlzGetItemExtendedTooltip(itemCreated) ) // sadtwig
	        endif
	        set cyclA = cyclA + 1
	    endloop
	
	    set caster = null
	    set target = null
	    set itemCreated = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endscope