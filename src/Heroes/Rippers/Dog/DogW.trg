{
  "Id": 503330611,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DogW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A155' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction DogWCast takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"dogw1\" ) )\r\n\tlocal real dmg = LoadReal( udg_hash, id, StringHash( \"dogw1\" ))\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\r\n    if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n    \tcall GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 225, null )\r\n    \tloop\r\n        \tset u = FirstOfGroup(g)\r\n        \texitwhen u == null\r\n        \tif unitst( u, caster, \"enemy\" ) then\r\n                call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n        \tendif\r\n        \tcall GroupRemoveUnit(g,u)\r\n        \tset u = FirstOfGroup(g)\r\n    \tendloop\r\n    else\r\n        call FlushChildHashtable( udg_hash, id )\r\n        call DestroyTimer( GetExpiredTimer() )\r\n    endif\r\n\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set caster = null\r\nendfunction \r\n\r\nfunction DogWRun takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"dogw\" ) )\r\n    local unit target = LoadUnitHandle( udg_hash, id, StringHash( \"dogwtrg\" ) )\r\n    local integer counter = LoadInteger( udg_hash, id, StringHash( \"dogw\" ) ) + 1\r\n    local real x = GetUnitX( target )\r\n    local real y = GetUnitY( target )\r\n    local real angle = Atan2( y - GetUnitY( caster ), x - GetUnitX( caster ) )\r\n    local real NewX = GetUnitX( caster ) + 30 * Cos( angle )\r\n    local real NewY = GetUnitY( caster ) + 30 * Sin( angle )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\tlocal integer id1\r\n\tlocal real dmg = LoadReal( udg_hash, id, StringHash( \"dogw\" ))\r\n\tlocal real dmgac = LoadReal( udg_hash, id, StringHash( \"dogwac\" ))\r\n    local real h = LoadReal( udg_hash, id, StringHash( \"dogwh\" ) )\r\n    local real flyHeight = LoadReal ( udg_hash, id, StringHash( \"dogwf\" ) )\r\n\r\n    if counter == 10 then\r\n        call SetUnitFlyHeight( caster, -600, 1500 )\r\n    endif\r\n\r\n    if counter == 20 or GetUnitState( caster, UNIT_STATE_LIFE) <= 0.405 then\r\n\t\tcall SetUnitPathing( caster, true )\r\n        call SetUnitFlyHeight( caster, h, flyHeight )\r\n\t\tcall UnitRemoveAbility( caster, 'Amrf' )\r\n\t\tcall PauseUnit( caster, false)\r\n\t\tcall UnitRemoveAbility( caster, 'A00L' )\r\n        if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n            call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 300, null )\r\n            loop\r\n                set u = FirstOfGroup(g)\r\n                exitwhen u == null\r\n                if unitst( u, caster, \"enemy\" ) then\r\n                    call dummyspawn( caster, 1, 'A0N5', 0, 0 )\r\n                    call UnitStun(caster, u, 1.5 )\r\n                    call UnitDamageTarget( bj_lastCreatedUnit, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n                endif\r\n                call GroupRemoveUnit(g,u) \r\n            endloop\r\n            call dummyspawn( caster, 10.5, 'A157', 'A0N5', 0 )\r\n            call SetUnitScale( bj_lastCreatedUnit, 1.5, 1.5, 1.5 )\r\n            \r\n            set id1 = GetHandleId( bj_lastCreatedUnit )\r\n            if LoadTimerHandle( udg_hash, id1, StringHash( \"dogw1\" ) ) == null  then\r\n                call SaveTimerHandle( udg_hash, id1, StringHash( \"dogw1\" ), CreateTimer() )\r\n            endif\r\n            set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( \"dogw1\" ) ) )\r\n            call SaveUnitHandle( udg_hash, id1, StringHash( \"dogw1\" ), bj_lastCreatedUnit)\r\n            call SaveReal( udg_hash, id1, StringHash( \"dogw1\" ), dmgac)\r\n            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"dogw1\" ) ), 1, true, function DogWCast )\r\n        endif\r\n        call FlushChildHashtable( udg_hash, id ) \r\n        call DestroyTimer( GetExpiredTimer() )\r\n    else \r\n        call SaveInteger( udg_hash, id, StringHash( \"dogw\" ), counter )\r\n        call SetUnitPosition( caster, NewX, NewY )\r\n    endif\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\nfunction Trig_DogW_Actions takes nothing returns nothing\r\n    local integer id \r\n    local integer lvl\r\n    local unit caster\r\n    local unit target\r\n    local real dmg\r\n\tlocal real dmgac\r\n    local real x\r\n    local real y\r\n    local real h\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A155'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set id = GetHandleId( caster )\r\n    set dmg = (75 + ( 25 * lvl )) * GetUnitSpellPower(caster)\r\n\tset dmgac = (10 + ( 5 * lvl )) * GetUnitSpellPower(caster)\r\n    set h = GetUnitDefaultFlyHeight(caster)\r\n\r\n\tset x = GetUnitX( target )\r\n\tset y = GetUnitY( target )\r\n\tcall PauseUnit( caster, true )\r\n\tcall UnitAddAbility( caster, 'A00L' )\r\n\tcall UnitAddAbility( caster, 'Amrf' )\r\n\tcall SetUnitFlyHeight( caster, 600, 1500 )\r\n\tcall SetUnitPathing( caster, false )\r\n\t\r\n\tif LoadTimerHandle( udg_hash, id, StringHash( \"dogw\" ) ) == null  then\r\n\t\tcall SaveTimerHandle( udg_hash, id, StringHash( \"dogw\" ), CreateTimer() )\r\n\tendif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"dogw\" ) ) )\r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"dogw\" ), caster)\r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"dogwtrg\" ), target )\r\n\tcall SaveReal( udg_hash, id, StringHash( \"dogw\" ), dmg)\r\n\tcall SaveReal( udg_hash, id, StringHash( \"dogwac\" ), dmgac)\r\n    call SaveReal( udg_hash, id, StringHash( \"dogwh\" ), h)\r\n    call SaveReal ( udg_hash, id, StringHash( \"dogwf\" ), GetUnitFlyHeight(caster))\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"dogw\" ) ), 0.02, true, function DogWRun ) \r\n\r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DogW takes nothing returns nothing\r\n    set gg_trg_DogW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DogW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_DogW, Condition( function Trig_DogW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DogW, function Trig_DogW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}