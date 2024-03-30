scope OrbOfVolcano initializer init
	
	globals
		private constant integer ITEM_ID = 'I0ER'
		
		private constant integer CHANCE = 10
		private constant integer SPAWN_DEVIATION = 500
		private constant integer DURATION = 20
		private constant integer AREA = 250
		
		private constant integer TICK = 4
		private constant integer DAMAGE = 50
		private constant real STUN_DURATION = 0.5
		
		private constant string EXPLODE_ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
        private constant string PARTICLE_EFFECT = "war3mapImported\\Spell Marker Gray.mdx"
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and LuckChance( AfterAttack.TriggerUnit, CHANCE ) 
	endfunction
	
	private function end takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local effect particle = LoadEffectHandle(udg_hash, id, StringHash("orb_volcano_duration"))
		
		call DestroyEffect( particle )
		call FlushChildHashtable( udg_hash, id )
		
		set particle = null
	endfunction
	
	private function tick takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local effect particle = LoadEffectHandle(udg_hash, id, StringHash("orb_volcano") )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash("orb_volcano_caster") )
		local real x = LoadReal( udg_hash, id, StringHash("orb_volcano_x") )
		local real y = LoadReal( udg_hash, id, StringHash("orb_volcano_y") )
		local group g = CreateGroup()
		local unit u
		
		if particle == null then
			call DestroyTimer( GetExpiredTimer() )
		else
			call GroupEnumUnitsInRange( g, x, y, AREA, null )
	        loop
	            set u = FirstOfGroup(g)
	            exitwhen u == null
	            if unitst( u, caster, "enemy" ) then
	            	call DestroyEffect( AddSpecialEffect( EXPLODE_ANIMATION, GetUnitX( u ), GetUnitY( u ) ) )
	                call UnitStun(caster, u, STUN_DURATION )
	                call UnitDamageTarget(caster, u, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	            endif
	            call GroupRemoveUnit(g,u)
	        endloop
		endif
		
		call DestroyGroup( g )
	    set g = null
	    set u = null
		set particle = null
		set caster = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
		local real x = GetUnitX( caster ) + GetRandomReal(-SPAWN_DEVIATION, SPAWN_DEVIATION)
		local real y = GetUnitY( caster ) + GetRandomReal(-SPAWN_DEVIATION, SPAWN_DEVIATION)
		local effect particle
		local integer id
		
		set particle = AddSpecialEffect( PARTICLE_EFFECT, x, y )
		call BlzSetSpecialEffectScale( particle, AREA / 100 )
	    
	    call InvokeTimerWithEffect( particle, "orb_volcano_duration", DURATION + 0.05, false, function end )
	    
	    set id = InvokeTimerWithEffect( particle, "orb_volcano", TICK, true, function tick )
	    call SaveUnitHandle( udg_hash, id, StringHash("orb_volcano_caster"), caster )
	    call SaveReal( udg_hash, id, StringHash("orb_volcano_x"), x )
	    call SaveReal( udg_hash, id, StringHash("orb_volcano_y"), y )
	    
	    set particle = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope
