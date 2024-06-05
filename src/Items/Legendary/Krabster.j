scope Krabster initializer init

	globals
		private constant integer ITEM_ID = 'I0H9'	
		
		private constant integer CHANCE = 2
	endglobals

	private function PotionCastEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "krabster_potion" ) ) 
	    
	    set udg_Caster = caster
	    set udg_RandomLogic = true
	    call TriggerExecute( udg_DB_Trigger_Pot[GetRandomInt(1, 10)] )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction
	
	private function PotionCast takes unit caster returns nothing
	    local integer id = GetHandleId( caster )
	    local timer timerUsed = CreateTimer()
	
	    call SaveTimerHandle( udg_hash, id, StringHash( "krabster_potion" ), timerUsed )
	    call SaveUnitHandle( udg_hash, GetHandleId( timerUsed ), StringHash( "krabster_potion" ), caster )
	    call TimerStart( timerUsed, 0.01, false, function PotionCastEnd )
	    
	    set timerUsed = null
	endfunction
	
	private function GoldGain takes unit caster returns nothing
		local integer i = CorrectPlayer(caster)
	    call moneyst(caster, 50)
	    set udg_Data[i + 260] = udg_Data[i + 260] + 50
	endfunction
	
	private function CrabSummon takes unit caster, unit target returns nothing
	    local integer i = 1
	    local integer iMax = 2
	    local location targetLoc
		local location summonSpawn
		local unit summon
		local boolean isTargetExist = target != null
	    
	    if isTargetExist then
	    	set targetLoc = GetUnitLoc(target)
	    else
	    	set targetLoc = GetUnitLoc(caster)
	    endif
	    
	    loop
	    	exitwhen i > iMax
	    	set summonSpawn = PolarProjectionBJ(targetLoc, 200, GetRandomInt(0, 360))
			set summon = CreateUnitAtLoc( GetOwningPlayer(caster), 'n03Y', summonSpawn, GetRandomInt(0, 360))
			call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", summon, "origin" ) )
			call UnitApplyTimedLife(summon, 'BTLF', 15 )
			if isTargetExist then
				call IssueTargetOrder( summon, "attack", target )
			endif
	    	call RemoveLocation(summonSpawn)
	    	set i = i + 1
    	endloop
    	
    	call RemoveLocation(targetLoc)
    	set targetLoc = null
    	set summonSpawn = null
    	set summon = null
	endfunction
	
	private function BuffGain takes unit caster returns nothing
	    call bufallst( caster, caster, 'A1G6', 0, 0, 0, 0, 'B0AN', "krabster_buff", 4 )
	    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", caster, "origin" ) )
	endfunction

	private function StatGain takes unit caster returns nothing
	    local integer rand = GetRandomInt(1, 3)
	
	    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", caster, "origin") )
	    if rand == 1 then
	        call statst( caster, 1, 0, 0, 148, true )
	        call textst( "|c00FF2020 +1 strength", caster, 64, 90, 10, 1 )
	    elseif rand == 2 then
	        call statst( caster, 0, 1, 0, 152, true )
	        call textst( "|c0020FF20 +1 agility", caster, 64, 90, 10, 1 )
	    elseif rand == 3 then
	        call statst( caster, 0, 0, 1, 156, true )
	        call textst( "|c002020FF +1 intelligence", caster, 64, 90, 10, 1 )
	    endif
	endfunction
	
	private function CrabPower takes unit caster, unit target returns nothing
		local integer randMax
	    local integer rand
	
		if udg_fightmod[3] == false and combat(caster, false, 0) then
			set randMax = 5
		else
			set randMax = 3
		endif
		set rand = GetRandomInt(1, randMax)
		/*call BJDebugMsg("rand: " + I2S(rand))
		call BJDebugMsg("randMax: " + I2S(randMax))*/
	    if rand == 1 then
	    	call PotionCast(caster)
	    elseif rand == 2 then
	    	call BuffGain(caster)
	    elseif rand == 3 then
	    	call CrabSummon(caster, target)
	    elseif rand == 4 then
	    	call GoldGain(caster)
	    elseif rand == 5 then
	    	//call BJDebugMsg("stat")
	    	call StatGain(caster)
	    endif
	endfunction
	
	//===========================================================================
	private function condition_spell takes nothing returns boolean
	    return LuckChance( GetSpellAbilityUnit(), CHANCE )
	endfunction
	
	private function action_spell takes nothing returns nothing
	    call CrabPower(GetSpellAbilityUnit(), null)
	endfunction
	//===========================================================================
	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and LuckChance( AfterAttack.TriggerUnit, CHANCE )
	endfunction
	
	private function action takes nothing returns nothing
	    call CrabPower(AfterAttack.GetDataUnit("caster"), AfterAttack.GetDataUnit("target"))
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	    call RegisterDuplicatableItemType(ITEM_ID, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action_spell, function condition_spell)
	endfunction



endscope