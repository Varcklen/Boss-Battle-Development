{
  "Id": 50332780,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer BATTLEMASTER_REQUIRES = 20000\r\nendglobals\r\n\r\nfunction Trig_Battlemaster_Conditions takes nothing returns boolean\r\n    return IsHeroHasItem(udg_DamageEventTarget, 'I0GN')\r\nendfunction\r\n\r\nfunction Trig_Battlemaster_Actions takes nothing returns nothing\r\n    local unit hero = udg_DamageEventTarget\r\n    local integer index = GetUnitUserData(hero)\r\n    local real currentState = udg_DamagedAllTime[index]\r\n    \r\n    if currentState >= BATTLEMASTER_REQUIRES then\r\n        call RemoveItem( GetItemOfTypeFromUnitBJ(hero, 'I0GN') )\r\n        call UnitAddItem(hero, CreateItem( 'I0GO', GetUnitX(hero), GetUnitY(hero)))\r\n        call textst( \"|c00ffffff Battlemaster done!\", hero, 64, GetRandomReal( 45, 135 ), 12, 1.5 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", GetUnitX(hero), GetUnitY(hero) ) )\r\n        set udg_QuestDone[index] = true\r\n    endif\r\n    \r\n    set hero = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Battlemaster takes nothing returns nothing\r\n    set gg_trg_Battlemaster = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Battlemaster, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Battlemaster, Condition( function Trig_Battlemaster_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Battlemaster, function Trig_Battlemaster_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}