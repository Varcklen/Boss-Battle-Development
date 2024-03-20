{
  "Id": 50332943,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HalifSpawn_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetEnteringUnit()) == 'n00O'\r\nendfunction\r\n\r\nfunction Trig_HalifSpawn_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\ArcaneExplosion.mdx\", GetUnitX(GetEnteringUnit()), GetUnitY(GetEnteringUnit()) ) )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( GetEnteringUnit() ), GetUnitY( GetEnteringUnit() ), 600, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, GetEnteringUnit(), \"enemy\" ) then\r\n            call UnitDamageTarget( GetEnteringUnit(), u, 500, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HalifSpawn takes nothing returns nothing\r\n    set gg_trg_HalifSpawn = CreateTrigger(  )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HalifSpawn, GetWorldBounds() )\r\n    call TriggerAddCondition( gg_trg_HalifSpawn, Condition( function Trig_HalifSpawn_Conditions ) )\r\n    call TriggerAddAction( gg_trg_HalifSpawn, function Trig_HalifSpawn_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}