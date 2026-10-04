scope OrbOfKelthuzad initializer init

	globals
		private constant integer ITEM_ID = 'I0DF'
		
		private constant real BUFF_DURATION = 4
		
		private constant integer EFFECT_ID = 'A0HX'
		private constant integer BUFF_ID = 'B092'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and IsUnitEnemy(AfterAttack.TargetUnit, GetOwningPlayer(AfterAttack.TriggerUnit) )
	endfunction 
	
	private function BuffCast takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit target = LoadUnitHandle(udg_hash, id, StringHash("orb_kelthuzad") )
		local unit caster = LoadUnitHandle(udg_hash, id, StringHash("orb_kelthuzad_caster") )
		local real duration = timebonus(caster, BUFF_DURATION)
	
		call bufallst( caster, target, EFFECT_ID, 0, 0, 0, 0, BUFF_ID, "orb_kelthuzad_buff", duration )
		call FlushChildHashtable( udg_hash, id )
	
		set caster = null
	    set target = null
	endfunction

	private function action takes nothing returns nothing
		local unit target = AfterAttack.GetDataUnit("target")
		local unit caster = AfterAttack.GetDataUnit("caster")
		local integer id
	    
	    //call BJDebugMsg("udg_DamageEventAmount1: " + R2S(udg_DamageEventAmount))
	    
	    set id = InvokeTimerWithUnit( target, "orb_kelthuzad", 0.01, false, function BuffCast )
	    call SaveUnitHandle(udg_hash, id, StringHash("orb_kelthuzad_caster"), caster)
	    
	    //call BJDebugMsg("udg_DamageEventAmount2: " + R2S(udg_DamageEventAmount))
	    
	    set caster = null
	    set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope