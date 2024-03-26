{
  "Id": 50332475,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mechanical_Relay_Conditions takes nothing returns boolean\r\n    return luckylogic( AfterAttack.TargetUnit, 15, 1, 100 )\r\nendfunction\r\n\r\nfunction Mech_relayCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit c = LoadUnitHandle( udg_hash, id, StringHash( \"mchr\" ) )\r\n    local real dmg = 15 + (15*SetCount_GetPieces(c, SET_MECH))\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    call spectime(\"Abilities\\\\Spells\\\\NightElf\\\\FanOfKnives\\\\FanOfKnivesCaster.mdl\", GetUnitX( c ), GetUnitY( c ), 1.6 )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( c ), GetUnitY( c ), 450, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, c, \"enemy\" ) then\r\n            call UnitTakeDamage( c, u, dmg, DAMAGE_TYPE_MAGIC )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    call FlushChildHashtable( udg_hash, id )\r\n\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set c = null\r\nendfunction\r\n\r\nfunction Trig_Mechanical_Relay_Actions takes nothing returns nothing\r\n    call InvokeTimerWithUnit(AfterAttack.TargetUnit, \"mchr\", 0.01, false, function Mech_relayCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mechanical_Relay takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I00I', AfterAttack, function Trig_Mechanical_Relay_Actions, function Trig_Mechanical_Relay_Conditions, \"target\" )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}