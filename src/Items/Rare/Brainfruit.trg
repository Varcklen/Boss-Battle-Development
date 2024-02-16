{
  "Id": 50332571,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer BRAINFRUIT_BONUS = 2\r\nendglobals\r\n\r\nfunction Trig_Brainfruit_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I04H'\r\nendfunction\r\n\r\nfunction Trig_Brainfruit_Actions takes nothing returns nothing \r\n    local unit caster = GetManipulatingUnit()\r\n    local integer bonus = 0\r\n    local integer i\r\n\r\n    set i = 1\r\n    loop\r\n        exitwhen i > SETS_COUNT\r\n        if SetCount_GetPieces(caster, i) > 0 then\r\n            set bonus = bonus + BRAINFRUIT_BONUS\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    call statst(caster, bonus, bonus, bonus, 0, true)\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\MarkOfChaos\\\\MarkOfChaosTarget.mdl\", caster, \"origin\" ) )\r\n    call stazisst( caster, GetManipulatedItem() )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Brainfruit takes nothing returns nothing\r\n    set gg_trg_Brainfruit = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Brainfruit, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Brainfruit, Condition( function Trig_Brainfruit_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Brainfruit, function Trig_Brainfruit_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}