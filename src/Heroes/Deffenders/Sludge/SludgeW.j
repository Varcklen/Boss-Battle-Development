scope SludgeW initializer init
	
	globals
		private constant integer HEALTH = 45
		private constant integer HEALTHLVL = 15
		private constant integer ATTACK = 2
		private constant integer DAMAGE = 160
		private constant integer DAMAGELVL = 40
		
		private constant integer ABILITY = 'A0R7'
		private constant integer ABILITYMINI = 'A0SO'
	       
	    public trigger Trigger = null
	    
	    private constant integer HASH_KEY_HP = StringHash("slugde_w_hp")
	    private constant integer HASH_KEY_AT = StringHash("slugde_w_at")
	endglobals
	
	private function castConditions takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY or GetSpellAbilityId() == ABILITYMINI
	endfunction
	
	private function AddValues takes unit caster, integer healthToGain, integer attackToGain, integer abilityUsed returns nothing
		local integer id
		local integer health
		local integer attack
		local unit original = null
		
		set id = GetHandleId( caster )
		if abilityUsed == ABILITYMINI then
			set original = LoadUnitHandle( udg_hash, id, StringHash( "sldg" ) )
			set id = GetHandleId( original )
			//call BJDebugMsg("Original")
		endif

		set health = LoadInteger( udg_hash, id, HASH_KEY_HP )
		set attack = LoadInteger( udg_hash, id, HASH_KEY_AT )

		call SaveInteger( udg_hash, id, HASH_KEY_HP, health + healthToGain )
		call SaveInteger( udg_hash, id, HASH_KEY_AT, attack + attackToGain )
		
		/*call BJDebugMsg("id: " + I2S( id ) )
		call BJDebugMsg("unit: " + GetUnitName( caster ) )
		call BJDebugMsg("original: " + GetUnitName( original ) )
		call BJDebugMsg("AddValues")
		call BJDebugMsg("hp: " + I2S(health))
		call BJDebugMsg("attack: " + I2S(attack))
		
		call BJDebugMsg("hp sum: " + I2S(health + healthToGain))
		call BJDebugMsg("attack sum: " + I2S(attack + attackToGain))*/
		
		set original = null
	endfunction
	
	private function castActions takes nothing returns nothing
	    local unit caster
	    local unit target
	    local integer lvl
	    local real dmg
	    local integer healthToGain
	    
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	        set lvl = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 300, "all", RT_NOT_CASTER, 0, 0 )
	        set lvl = udg_Level
	        call textst( udg_string[0] + GetObjectName(ABILITY), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	        if GetSpellAbilityId() == ABILITYMINI then
	            set lvl = LoadInteger( udg_hash, GetHandleId(caster), StringHash( "sldgw" ) )
	        else
	            set lvl = GetUnitAbilityLevel(caster, ABILITY)
	        endif
	    endif
	
	    set dmg = DAMAGE + DAMAGELVL * lvl

	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(target), GetUnitY(target) ) )
	    call UnitTakeDamage( caster, target, dmg, DAMAGE_TYPE_MAGIC)
	
	    if not(udg_fightmod[3]) and combat(caster, false, 0) and IsUnitAlive(caster) then
	    	set healthToGain = HEALTH + HEALTHLVL * lvl
	    	
	        call BlzSetUnitMaxHP( caster, R2I( BlzGetUnitMaxHP(caster) + healthToGain ) )
			call BlzSetUnitBaseDamage( caster, R2I( BlzGetUnitBaseDamage(caster, 0) + ATTACK ), 0 )

			call AddValues( caster, healthToGain, ATTACK, GetSpellAbilityId() )
	    endif
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
    private function OnBattleEnd_Condition takes nothing returns boolean
    	/*call BJDebugMsg("check: " + I2S(LoadInteger( udg_hash, GetHandleId( BattleEnd.GetDataUnit("caster") ), HASH_KEY_HP )))
    	call BJDebugMsg("unit: " + GetUnitName( BattleEnd.GetDataUnit("caster") ))*/
	    return LoadInteger( udg_hash, GetHandleId( BattleEnd.GetDataUnit("caster") ), HASH_KEY_HP ) != 0
	endfunction
    
	private function OnBattleEnd takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer id = GetHandleId( caster )
		local integer healthToLose = LoadInteger( udg_hash, id, HASH_KEY_HP )
		local integer attackToLose = LoadInteger( udg_hash, id, HASH_KEY_AT )
        
        /*call BJDebugMsg("healthToLose: " + I2S(healthToLose))
        call BJDebugMsg("attackToLose: " + I2S(attackToLose))*/
        
        call BlzSetUnitMaxHP( caster, R2I( BlzGetUnitMaxHP(caster) - healthToLose ) )
		call BlzSetUnitBaseDamage( caster, R2I( BlzGetUnitBaseDamage(caster, 0) - attackToLose ), 0 )
		call SaveInteger( udg_hash, id, HASH_KEY_HP, 0 )
		call SaveInteger( udg_hash, id, HASH_KEY_AT, 0 )
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trigStart = CreateTrigger(  )
	    set Trigger = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( Trigger, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( Trigger, Condition( function castConditions ) )
	    call TriggerAddAction( Trigger, function castActions )
	    
	    call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	    
	    set trigStart = null
	endfunction

endscope