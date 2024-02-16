{
  "Id": 50332643,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Orb_of_Shadow_Conditions takes nothing returns boolean\r\n    if (GetUnitAbilityLevel( udg_DamageEventSource, 'B029') > 0 or inv( udg_DamageEventSource, 'I0FU') > 0) == false then\r\n        return false\r\n    elseif IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO) then\r\n        return false\r\n    elseif IsUnitType( udg_DamageEventTarget, UNIT_TYPE_ANCIENT) then\r\n        return false\r\n    elseif udg_IsDamageSpell then\r\n        return false\r\n    elseif luckylogic( udg_DamageEventSource, 8, 1, 100 ) == false then\r\n        return false\r\n    elseif IsUnitDead(udg_DamageEventTarget) then\r\n        return false\r\n    endif\r\n\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_Orb_of_Shadow_Actions takes nothing returns nothing\r\n    call PlaySpecialEffect(\"Abilities\\\\Spells\\\\Other\\\\Charm\\\\CharmTarget.mdl\", udg_DamageEventTarget)\r\n    if GetUnitTypeId( udg_DamageEventTarget ) != 'u00X' then\r\n        call SetUnitOwner( udg_DamageEventTarget, GetOwningPlayer(udg_DamageEventSource), true )\r\n        call UnitApplyTimedLife( udg_DamageEventTarget, 'BTLF', 30 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Orb_of_Shadow takes nothing returns nothing\r\n    call CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_Orb_of_Shadow_Actions, function Trig_Orb_of_Shadow_Conditions )//udg_DamageEvent\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}