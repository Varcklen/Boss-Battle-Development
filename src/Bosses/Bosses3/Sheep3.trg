{
  "Id": 50333455,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n007' and GetUnitLifePercent(udg_DamageEventTarget) <= 50. and GetOwningPlayer(udg_DamageEventTarget) == Player(10)\r\nendfunction\r\n\r\nfunction Sheep3Repeat takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bstt3u\" ) )\r\n    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( \"bstt3d\" ) )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local integer id1\r\n    local boolean l = false\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphTarget.mdl\", GetUnitX( dummy ), GetUnitY( dummy ) + 100 ) )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphTarget.mdl\", GetUnitX( dummy ) + 140, GetUnitY( dummy ) - 140 ) )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphTarget.mdl\", GetUnitX( dummy ) - 140, GetUnitY( dummy ) - 140 ) )\r\n    \r\n    call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 200, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, boss, \"enemy\" ) then\r\n            call UnitPoly( boss, u, 'n02L', 5 )\r\n            if IsUnitType( u, UNIT_TYPE_HERO) then\r\n                set l = true\r\n            endif\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    if l then\r\n        set id1 = GetHandleId( dummy )\r\n        if LoadTimerHandle( udg_hash, id1, StringHash( \"bstt3d\" ) ) == null  then\r\n            call SaveTimerHandle( udg_hash, id1, StringHash( \"bstt3d\" ), CreateTimer() )\r\n        endif\r\n        set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( \"bstt3d\" ) ) ) \r\n        call SaveUnitHandle( udg_hash, id1, StringHash( \"bstt3d\" ), dummy )\r\n        call SaveUnitHandle( udg_hash, id1, StringHash( \"bstt3u\" ), boss )\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( dummy ), StringHash( \"bstt3d\" ) ), bosscast(1), false, function Sheep3Repeat )\r\n    else\r\n        call RemoveUnit( dummy )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    endif\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set boss = null\r\n    set dummy = null\r\nendfunction \r\n\r\nfunction Trig_Sheep3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer id\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n            set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'u000', GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ), 270 )\r\n            call SetUnitScale(bj_lastCreatedUnit, 2, 2, 2 )\r\n            call UnitAddAbility( bj_lastCreatedUnit, 'A136')\r\n        \r\n            set id = GetHandleId( bj_lastCreatedUnit )\r\n            if LoadTimerHandle( udg_hash, id, StringHash( \"bstt3d\" ) ) == null then\r\n                call SaveTimerHandle( udg_hash, id, StringHash( \"bstt3d\" ), CreateTimer() )\r\n            endif\r\n            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"bstt3d\" ) ) ) \r\n            call SaveUnitHandle( udg_hash, id, StringHash( \"bstt3d\" ), bj_lastCreatedUnit )\r\n            call SaveUnitHandle( udg_hash, id, StringHash( \"bstt3u\" ), udg_DamageEventTarget )\r\n            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"bstt3d\" ) ), bosscast(1), false, function Sheep3Repeat )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep3 takes nothing returns nothing\r\n    set gg_trg_Sheep3 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Sheep3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Sheep3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Sheep3, Condition( function Trig_Sheep3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sheep3, function Trig_Sheep3_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}