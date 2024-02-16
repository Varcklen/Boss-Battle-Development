{
  "Id": 50332548,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer THIEF_VIST_CHANCE = 10\r\n    constant integer THIEF_VIST_GOLD = 30\r\nendglobals\r\n\r\nfunction Trig_Thiefs_Vest_Conditions takes nothing returns boolean\r\n    if udg_IsDamageSpell then\r\n        return false\r\n    elseif udg_fightmod[3] then\r\n        return false\r\n    elseif IsHeroHasItem(udg_DamageEventSource, 'I0CV') == false then\r\n        return false\r\n    elseif combat( udg_DamageEventSource, false, 0 ) == false then\r\n        return false\r\n    elseif IsUnitEnemy( udg_DamageEventSource, GetOwningPlayer( udg_DamageEventTarget ) ) == false then\r\n        return false\r\n    elseif luckylogic( udg_DamageEventSource, THIEF_VIST_CHANCE, 1, 100 ) == false then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_Thiefs_Vest_Actions takes nothing returns nothing\r\n    call moneyst(udg_DamageEventSource, THIEF_VIST_GOLD)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Thiefs_Vest takes nothing returns nothing\r\n    set gg_trg_Thiefs_Vest = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Thiefs_Vest, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Thiefs_Vest, Condition( function Trig_Thiefs_Vest_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Thiefs_Vest, function Trig_Thiefs_Vest_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}