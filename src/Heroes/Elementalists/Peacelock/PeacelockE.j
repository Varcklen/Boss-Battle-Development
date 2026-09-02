scope PeacelockE initializer init

	globals
		private real Value = 0
		private unit AuraOwner = null
		private constant integer BUFF_ID = 'B03A'
		
		//private constant string ANIMATION = "Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl"
		private constant integer HASH_KEY = StringHash("peacelock_e")
	endglobals

	private function condition takes nothing returns boolean
        return GetUnitAbilityLevel( AfterHeal.TargetUnit, BUFF_ID) > 0
    endfunction

    private function action takes nothing returns nothing
    	local unit target = AfterHeal.GetDataUnit("target")
    	local real heal = AfterHeal.GetDataReal("heal")
    	local integer id = GetHandleId(target)
    	local real extraDamage = LoadReal(udg_hash, id, HASH_KEY)
    	local real toAdd = heal * Value

    	//call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
    	call SaveReal(udg_hash, id, HASH_KEY, extraDamage + toAdd )

        set target = null
    endfunction
    
    //===========================================================================
    private function OnLearn_Condition takes nothing returns boolean
	    return GetLearnedSkill() == 'A04X'
	endfunction
	
	private function OnLearn takes nothing returns nothing
		local integer level = GetUnitAbilityLevel( GetLearningUnit(), 'A04X')
		
		set Value = 0.25 + ( 0.15 * level )
	    set AuraOwner = GetLearningUnit()
	endfunction
	
	//===========================================================================
	private function AfterDamage_Conditions takes nothing returns boolean
        return LoadReal(udg_hash, GetHandleId(udg_DamageEventSource), HASH_KEY) > 0 and udg_IsDamageSpell == false
    endfunction
    
    private function AfterDamage takes nothing returns nothing
    	local unit dealer = udg_DamageEventSource
    	local integer id = GetHandleId(dealer)
    	local real extraDamage = LoadReal(udg_hash, id, HASH_KEY)
    	
    	set udg_DamageEventAmount = udg_DamageEventAmount + extraDamage
    	call SaveReal(udg_hash, id, HASH_KEY, 0 )
	    
    	set dealer = null
    endfunction
    
    //===========================================================================
    private function AtBattleStart_Condition takes nothing returns boolean
        return LoadReal(udg_hash, GetHandleId(BattleStart.TargetUnit), HASH_KEY) > 0
    endfunction
    
    private function AtBattleStart takes nothing returns nothing
    	local unit hero = BattleStart.GetDataUnit("caster")
    	local integer id = GetHandleId(hero)

    	call SaveReal(udg_hash, id, HASH_KEY, 0 )
	    
    	set hero = null
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
        call AfterHeal.AddListener(function action, function condition)
        call CreateNativeEvent( EVENT_PLAYER_HERO_SKILL, function OnLearn, function OnLearn_Condition )
        call CreateEventTrigger( "udg_DamageModifierEvent", function AfterDamage, function AfterDamage_Conditions )
        call BattleStart.AddListener(function AtBattleStart, function AtBattleStart_Condition)
    endfunction

endscope