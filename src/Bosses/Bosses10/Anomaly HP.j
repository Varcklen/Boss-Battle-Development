scope AnomalyHP initializer init

	globals
		public trigger Trigger = null
		
		private constant real HP_HEAL_PERCENT = 0.4
		
		private constant string SPAWN_ANIMATION = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"
		private constant string USE_ANIMATION = "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl"
		private constant string MODEL = "Healing Surge.mdx"
		private constant real MODEL_SIZE = Wendigo1_ANOMALY_AREA_SIZE / 100.
	endglobals
	
	private function UnitAffect takes unit target returns nothing
		call healst( target, null, GetUnitState( target, UNIT_STATE_MAX_LIFE) * HP_HEAL_PERCENT )
        call DestroyEffect( AddSpecialEffectTarget( USE_ANIMATION, target, "origin") )
	endfunction
	
	private function Check takes effect anomaly, integer id, timer usedTimer returns nothing
		local boolean targetFound = false
	    local group g = CreateGroup()
	    local unit u
	
		call GroupEnumUnitsInRange( g, BlzGetLocalSpecialEffectX(anomaly), BlzGetLocalSpecialEffectY(anomaly), Wendigo1_ANOMALY_AREA_SIZE, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if IsHero( u ) then
                call UnitAffect(u)
                set targetFound = true
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        if targetFound then
        	//call BJDebugMsg("end")
        	call BlzSetSpecialEffectZ( anomaly, -1000 )
        	call DestroyEffect(anomaly)
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( usedTimer )
        endif
	        
        call GroupClear( g )
	    set u = null
	    set g = null
	endfunction
	
	private function AreaUpdate takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local effect anomaly = LoadEffectHandle( udg_hash, id, StringHash( "boss_wendigo_anomaly" ) )

	    if not( udg_fightmod[0] ) then
	    	//call BJDebugMsg("fight end")
	    	call DestroyEffect(anomaly)
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call Check(anomaly, id, GetExpiredTimer() )
	    endif
	    
	    set anomaly = null
	endfunction

	public function action takes nothing returns nothing
		local effect anomaly
		
		/*call BJDebugMsg("hp")
		call BJDebugMsg("x: " + R2S( GetLocationX(Wendigo1_LocationSpawn) ))
		call BJDebugMsg("y: " + R2S( GetLocationY(Wendigo1_LocationSpawn) ))*/
		
		set anomaly = AddSpecialEffectLoc(MODEL, Wendigo1_LocationSpawn)
		call BlzSetSpecialEffectScale(anomaly, MODEL_SIZE)
		call BlzSetSpecialEffectTimeScale( anomaly, Wendigo1_ANOMALY_ANIMATION_SPEED)
		call DestroyEffect( AddSpecialEffectLoc( SPAWN_ANIMATION, Wendigo1_LocationSpawn ) )

		call InvokeTimerWithEffect( anomaly, "boss_wendigo_anomaly", Wendigo1_ANOMALY_CHECK_TICK, true, function AreaUpdate )
 
        set anomaly = null
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope