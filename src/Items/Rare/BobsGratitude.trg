{
  "Id": 50332563,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope bobgrat\r\n\r\n    function Trig_BobsGratitude_Conditions takes nothing returns boolean\r\n        return GetSpellAbilityId() == 'AZ06' and IsSetItem(GetItemTypeId(GetSpellTargetItem()),9)\r\n    endfunction\r\n\r\n    function Trig_BobsGratitude_Actions takes nothing returns nothing\r\n        local unit u = GetSpellAbilityUnit()\r\n        //local integer h = eyest( u )\r\n        local integer itd = GetItemTypeId(GetSpellTargetItem())\r\n\r\n        call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n        call stazisst( u, GetItemOfTypeFromUnitBJ( u, 'IZ02') )\r\n        call UnitAddItem( u, CreateItem(itd, GetUnitX(u), GetUnitY(u) ) )\r\n\r\n        set u = null\r\n    endfunction\r\n\r\n//===========================================================================\r\n    function InitTrig_BobsGratitude takes nothing returns nothing\r\n        set gg_trg_BobsGratitude = CreateTrigger(  )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_BobsGratitude, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n        call TriggerAddCondition( gg_trg_BobsGratitude, Condition( function Trig_BobsGratitude_Conditions ) )\r\n        call TriggerAddAction( gg_trg_BobsGratitude, function Trig_BobsGratitude_Actions )\r\n    endfunction\r\n\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}