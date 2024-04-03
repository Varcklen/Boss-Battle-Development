scope Fedor2 initializer init

    globals
    	trigger gg_trg_Fedor2 = null
    
        private constant integer ID_BOSS = 'h00B'
        private constant integer ID_TRAIN = 'h00C'
        private constant integer ID_INVUL = 'Avul'
        
        private constant integer HEALTH_CHECK = 33
        private constant integer COOLDOWN = 7
        private constant integer DELAY = 3
        private constant real TICK = 0.04
        private constant integer FLIGHT_LENGTH = 24
        private constant integer DAMAGE = 40
        private constant integer SPEED = 42
        private constant integer AREA = 128
        private constant integer WAVES = 3
        private constant integer START_ANGLE = -90
        private constant integer ANGLE_DIFFERENCE = 45
        
        private constant string WAVE_ANIMATION = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
        private constant string TELEPORT_ANIMATION = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl"
    endglobals

    private function condition takes nothing returns boolean
        return GetUnitTypeId(udg_DamageEventTarget) == ID_BOSS and GetUnitLifePercent(udg_DamageEventTarget) <= HEALTH_CHECK
    endfunction
    
    private function DealDamage takes effect wave, group nodmg, unit boss returns nothing
        local group g = CreateGroup()
        local unit u
        
        call GroupEnumUnitsInRange( g, BlzGetLocalSpecialEffectX( wave ), BlzGetLocalSpecialEffectY( wave ), AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, boss, "enemy" ) and not( IsUnitInGroup( u, nodmg ) ) then
                call UnitTakeDamage(boss, u, DAMAGE, DAMAGE_TYPE_MAGIC)
                call GroupAddUnit( nodmg, u )
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyGroup( g )
        set u = null
        set g = null
        set wave = null
        set nodmg = null
        set boss = null
    endfunction

    private function WaveUse takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local integer counter = LoadInteger( udg_hash, id, StringHash( "bsfdw" ) ) + 1
        local effect wave = LoadEffectHandle( udg_hash, id, StringHash( "bsfdw" ) )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsfdwb" ) )
        local group nodmg = LoadGroupHandle( udg_hash, id, StringHash( "bsfdwg" ) )
        local real angle = LoadReal( udg_hash, id, StringHash( "bsfdw" ) )
        local location newLoc = null

        if counter >= FLIGHT_LENGTH or wave == null then
            call DestroyEffect( wave )
            call GroupClear( nodmg )
            call DestroyGroup( nodmg )
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            set newLoc = LocationSystem_GetMovedEffect(wave, angle, SPEED)//GetMovedPoint( wave, angle, SPEED )
            call BlzSetSpecialEffectPositionLoc( wave, newLoc )
            call DealDamage( wave, nodmg, boss )
            call SaveInteger( udg_hash, id, StringHash( "bsfdw" ), counter )
        endif

        call RemoveLocation(newLoc)
        set newLoc = null
        set wave = null
        set boss = null
        set nodmg = null
    endfunction
    
    private function CreateWave takes unit boss, unit train, real angle returns nothing
        local effect wave
        local integer id
    
        set wave = AddSpecialEffect( WAVE_ANIMATION, GetUnitX(train), GetUnitY(train))
        call BlzSetSpecialEffectYaw( wave, Deg2Rad(angle) )
        
        set id = InvokeTimerWithEffect( wave, "bsfdw", TICK, true, function WaveUse )
        call SaveUnitHandle( udg_hash, id, StringHash( "bsfdwb" ), boss )
        //call SaveUnitHandle( udg_hash, id, StringHash( "bsfdwtr" ), train )
        call SaveReal( udg_hash, id, StringHash( "bsfdw" ), angle )
        call SaveGroupHandle( udg_hash, id, StringHash( "bsfdwg" ), CreateGroup() )
    
        set wave = null
        set boss = null
    endfunction

    function FedorTrain takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local integer i
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsfd2" ) )
        local unit train = LoadUnitHandle( udg_hash, id, StringHash( "bsfd2tr" ) )
        
        if IsUnitDead(train) or udg_fightmod[0] == false then
        	if udg_fightmod[0] == false then
        		call RemoveUnit(boss)
        	endif
            call DestroyTimer( GetExpiredTimer() )
        else
            set i = 1
            loop
                exitwhen i > WAVES
                call CreateWave( boss, train, GetUnitFacing( train ) + START_ANGLE + ( i * ANGLE_DIFFERENCE ) )
                set i = i + 1
            endloop
            call aggro( train )
        endif
        
        set boss = null
        set train = null
    endfunction

    function FedorRepeat takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsfd1" ) )
        local unit train = LoadUnitHandle( udg_hash, id, StringHash( "bsfd1tr" ) )
        local integer id1
        
        if IsUnitDead(train) or IsUnitDead(boss) or udg_fightmod[0] == false then
            call UnitRemoveAbility( boss, ID_INVUL)
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        elseif IsUnitInTransport( boss, train ) then
            //if IsUnitAlive(boss) and udg_fightmod[0] then
            call SetUnitPathing( train, true )
            call UnitRemoveAbility( boss, ID_INVUL)
            call aggro( train )
            
            set id1 = InvokeTimerWithUnit(boss, "bsfd2", bosscast(COOLDOWN), true, function FedorTrain )
            call SaveUnitHandle( udg_hash, id1, StringHash( "bsfd2tr" ), train )
            //endif
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() ) 
        else
            call IssueTargetOrder( boss, "board", train )
        endif
        
        set boss = null
        set train = null
    endfunction

    function FedorCast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsfd" ) )
        local unit train = LoadUnitHandle( udg_hash, id, StringHash( "bsfdtr" ) )
        local integer id1 = GetHandleId( boss )    
        
        call SetDestructableAnimation(udg_DEST_GATE, "stand")
        if IsUnitAlive(boss) and udg_fightmod[0] then
            call PauseUnit( boss, false )
            call IssueTargetOrder( boss, "board", train )

            set id1 = InvokeTimerWithUnit(boss, "bsfd1", 0.2, true, function FedorRepeat )
            call SaveUnitHandle( udg_hash, id1, StringHash( "bsfd1tr" ), train )
        endif
        call FlushChildHashtable( udg_hash, id )
        
        set boss = null
        set train = null
    endfunction

    private function action takes nothing returns nothing
        local unit boss = udg_DamageEventTarget
        local unit train
        local integer id 
        
        call DisableTrigger( GetTriggeringTrigger() )
        if udg_Boss_Rect == gg_rct_ArenaBoss then
            call SetDestructableAnimation(udg_DEST_GATE, "death alternate")
        endif
        
        call IssueImmediateOrder( boss, "stop" )
        call PauseUnit( boss, true)
        call UnitAddAbility( boss, ID_INVUL )
        call SetUnitPosition( boss, GetRectCenterX(udg_Boss_Rect), GetRectCenterY(udg_Boss_Rect) + 600 )
        call PlaySpecialEffect(TELEPORT_ANIMATION, boss)
        
        set train = CreateUnit( GetOwningPlayer( boss ), ID_TRAIN, GetRectCenterX(udg_Boss_Rect) - 2000, GetRectCenterY(udg_Boss_Rect) + 600, 0 )
        call IssuePointOrder( train, "move", GetUnitX( boss ), GetUnitY( boss ) )
        call SetUnitPathing( train, false )
        
        set id = InvokeTimerWithUnit(boss, "bsfd", DELAY, false, function FedorCast )
        call SaveUnitHandle( udg_hash, id, StringHash( "bsfdtr" ), train )
        
        set train = null
        set boss = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set gg_trg_Fedor2 = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
        call DisableTrigger( gg_trg_Fedor2 )
    endfunction

endscope