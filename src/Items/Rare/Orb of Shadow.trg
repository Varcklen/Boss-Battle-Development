{
  "Id": 50332643,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Orb_of_Shadow_Conditions takes nothing returns boolean\r\n    if IsUnitType( AfterAttack.TargetUnit, UNIT_TYPE_HERO) then\r\n        return false\r\n    elseif IsUnitType( AfterAttack.TargetUnit, UNIT_TYPE_ANCIENT) then\r\n        return false\r\n    elseif udg_IsDamageSpell then\r\n        return false\r\n    elseif luckylogic( AfterAttack.TriggerUnit, 8, 1, 100 ) == false then\r\n        return false\r\n    elseif IsUnitDead(AfterAttack.TargetUnit) then\r\n        return false\r\n    endif\r\n\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_Orb_of_Shadow_Actions takes nothing returns nothing\r\n\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\tlocal unit target = AfterAttack.GetDataUnit(\"target\")\r\n\t\r\n    call PlaySpecialEffect(\"Abilities\\\\Spells\\\\Other\\\\Charm\\\\CharmTarget.mdl\", target)\r\n    if IsPermaBuffAffected(target) then\r\n        call SetUnitOwner( target, GetOwningPlayer(caster), true )\r\n        call UnitApplyTimedLife( target, 'BTLF', 30 )\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Orb_of_Shadow takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0FU', AfterAttack, function Trig_Orb_of_Shadow_Actions, function Trig_Orb_of_Shadow_Conditions )\r\nendfunction\r\n\r\n\r\n\r\n/*GetUnitAbilityLevel( udg_DamageEventSource, 'B029') > 0*/",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}