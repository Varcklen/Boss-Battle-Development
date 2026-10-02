scope BanditArmorDizzy initializer init

	globals
		private constant integer ITEM_ID = 'I06K'
		
		private constant integer CHANCE = 25
		private constant real BUFF_DURATION = 1.5
		private constant integer EFFECT_ID = 'A1K2'
		private constant integer BUFF_ID = 'B0BC'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and LuckChance( AfterAttack.TriggerUnit, CHANCE )
	endfunction 

	private function BuffCast takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit target = LoadUnitHandle(udg_hash, id, StringHash("bandit_steps_dizzy_delay") )
		local unit caster = LoadUnitHandle(udg_hash, id, StringHash("bandit_steps_dizzy_delay_caster") )
		local real duration = timebonus(caster, BUFF_DURATION)
	
		call bufallst( caster, target, EFFECT_ID, 0, 0, 0, 0, BUFF_ID, "bandit_steps_dizzy", duration )
		call FlushChildHashtable( udg_hash, id )
	
		set caster = null
	    set target = null
	endfunction

	private function action takes nothing returns nothing
		local unit target = AfterAttack.GetDataUnit("target")
		local unit caster = AfterAttack.GetDataUnit("caster")
		local integer id
	    
	    //call BJDebugMsg("udg_DamageEventAmount1: " + R2S(udg_DamageEventAmount))
	    
	    set id = InvokeTimerWithUnit( target, "bandit_steps_dizzy_delay", 0.01, false, function BuffCast )
	    call SaveUnitHandle(udg_hash, id, StringHash("bandit_steps_dizzy_delay_caster"), caster)
	    
	    //call BJDebugMsg("udg_DamageEventAmount2: " + R2S(udg_DamageEventAmount))
	    
	    set caster = null
	    set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope