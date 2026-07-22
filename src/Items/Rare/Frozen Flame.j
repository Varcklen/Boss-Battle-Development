scope FrozenFlame initializer init

	globals
		private constant integer ABILITY_ID = 'A0OK'
		private constant integer ITEM_ID = 'I0DY'
		
		private constant real SHIELD_GAIN_MULTIPLIER = 0.5
		private constant integer BASE_COST = 500
		private constant integer DAMAGE = 1000
		private constant string ANIMATION = "Abilities\\Spells\\Human\\FlameStrike\\FlameStrike1.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd
	    local unit caster
	    local unit target
	    
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
	
	    set cyclAEnd = eyest( caster )
	    call spectime(ANIMATION, GetUnitX( target ), GetUnitY( target ), 1 )
	    loop
	        exitwhen cyclA > cyclAEnd
	        call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	        set cyclA = cyclA + 1
	    endloop
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
	private function OnShieldGain_Conditions takes nothing returns boolean
	    return combat( ShieldGain.GetDataUnit("target"), false, 0)
	endfunction
	
	private function OnShieldGain takes nothing returns nothing
	    local item itemUsed = Trigger_GetItemUsed()
	    local integer shieldGain = ShieldGain.GetDataInteger("amount") 
	    local ability abilityUsed
	    local integer abilityCost

	    if itemUsed == null then
	        return
	    endif
	    
	    //call BJDebugMsg("initial gain: " + I2S(shieldGain))
	    set shieldGain = R2I(SHIELD_GAIN_MULTIPLIER * shieldGain)
	    //call BJDebugMsg("reduction: " + I2S(shieldGain))
	    set abilityUsed = BlzGetItemAbility( itemUsed, ABILITY_ID )
        if abilityUsed != null then
        	set abilityCost = BlzGetAbilityIntegerLevelField(abilityUsed, ABILITY_ILF_MANA_COST, 0)
            call BlzSetAbilityIntegerLevelFieldBJ( abilityUsed, ABILITY_ILF_MANA_COST, 0, IMaxBJ(0, abilityCost - shieldGain) )
        endif
	
	    set abilityUsed = null
	    set itemUsed = null
	endfunction
	
	//===========================================================================
	private function OnBattleStart takes nothing returns nothing
		local item itemUsed = Trigger_GetItemUsed()
		local ability abilityUsed

		if itemUsed == null then
	        return
	    endif
	    
	    set abilityUsed = BlzGetItemAbility( itemUsed, ABILITY_ID )
        if abilityUsed != null then
            call BlzSetAbilityIntegerLevelFieldBJ( abilityUsed, ABILITY_ILF_MANA_COST, 0, BASE_COST )
        endif

		set abilityUsed = null
	    set itemUsed = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, ShieldGain, function OnShieldGain, function OnShieldGain_Conditions, "target")
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function OnBattleStart, null, null)
	endfunction

endscope