scope PeacelockEDamage initializer init

	globals
		private boolean noLoop = false
	endglobals

	private function condition takes nothing returns boolean
        return noLoop == false and GetUnitAbilityLevel( AfterHeal.TargetUnit, 'B03A') > 0
    endfunction

	private function PeacelockE_End takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit enemy = LoadUnitHandle( udg_hash, id, StringHash( "pcke" ) )
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "pckec" ) )
        local real dmg = LoadReal( udg_hash, id, StringHash( "pcke" ) )

        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Weapons\\IllidanMissile\\IllidanMissile.mdl", enemy, "origin" ) )
        call UnitDamageTarget( caster, enemy, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
		set noLoop = false

        call FlushChildHashtable( udg_hash, id )

        set enemy = null
        set caster = null
    endfunction
    
    private function action takes nothing returns nothing
    	local unit caster = AfterHeal.GetDataUnit("caster")
    	local unit target = AfterHeal.GetDataUnit("target")
    	local unit randomTarget
    	local real heal = AfterHeal.GetDataReal("heal")
    	local integer id
    
        set randomTarget = randomtarget( target, 600, "enemy", 0, 0, 0 )
        if randomTarget != null then
        	set noLoop = true
        
            set id = GetHandleId( randomTarget )
    
            if LoadTimerHandle( udg_hash, id, StringHash( "pcke" ) ) == null then
                call SaveTimerHandle( udg_hash, id, StringHash( "pcke" ), CreateTimer() )
            endif
            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "pcke" ) ) ) 
            call SaveUnitHandle( udg_hash, id, StringHash( "pcke" ), randomTarget )
            call SaveUnitHandle( udg_hash, id, StringHash( "pckec" ), udg_unit[0] )
            call SaveReal( udg_hash, id, StringHash( "pcke" ), heal * udg_real[2] )
            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( randomTarget ), StringHash( "pcke" ) ), 0.01, false, function PeacelockE_End )
        endif
        
        set caster = null
        set target = null
    endfunction

	private function init takes nothing returns nothing
        call AfterHeal.AddListener(function action, function condition)
    endfunction

endscope