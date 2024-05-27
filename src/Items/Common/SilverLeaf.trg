{
  "Id": 50332516,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SilverLeaf_Conditions takes nothing returns boolean \r\n\treturn GetItemTypeId(GetManipulatedItem()) == 'I02F'\r\nendfunction \r\n\r\nfunction ArgenLeafCast takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit hero = LoadUnitHandle( udg_hash, id, StringHash( \"silverleaf_caster\" ) )\r\n\tlocal item it = LoadItemHandle( udg_hash, id, StringHash( \"silverleaf\" ) )\r\n    \r\n    if UnitHasItem( hero,it ) == false then\r\n        call DestroyTimer( GetExpiredTimer() )\r\n    elseif IsUnitAlive( hero ) then\r\n        call healst( hero, null, GetUnitState( hero, UNIT_STATE_MAX_LIFE) * 0.06 )\r\n        call spectimeunit( hero, \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\n    endif\r\n    \r\n    set hero = null\r\n    set it = null\r\nendfunction \r\n\r\nfunction Trig_SilverLeaf_Actions takes nothing returns nothing \r\n\tlocal integer id\r\n\t\r\n\tset id = InvokeTimerWithItem( GetManipulatedItem(), \"silverleaf\", 8, true, function ArgenLeafCast )\r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"silverleaf_caster\" ), GetManipulatingUnit() ) \r\nendfunction \r\n\r\n//=========================================================================== \r\nfunction InitTrig_SilverLeaf takes nothing returns nothing \r\n\tset gg_trg_SilverLeaf = CreateTrigger( ) \r\n\tcall TriggerRegisterAnyUnitEventBJ( gg_trg_SilverLeaf, EVENT_PLAYER_UNIT_PICKUP_ITEM ) \r\n\tcall TriggerAddCondition( gg_trg_SilverLeaf, Condition( function Trig_SilverLeaf_Conditions ) ) \r\n\tcall TriggerAddAction( gg_trg_SilverLeaf, function Trig_SilverLeaf_Actions ) \r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}