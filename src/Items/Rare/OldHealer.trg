{
  "Id": 50332638,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OldHealer_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A14T'\r\nendfunction\r\n\r\nfunction Trig_OldHealer_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local unit caster\r\n    local unit target\r\n    local real dmg\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", \"notfull\", \"\", \"\", \"\" )\r\n        call textst( udg_string[0] + GetObjectName('A14T'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    set cyclAEnd = eyest( caster )\r\n    set dmg = 300. + ( 100. * ( SetCount_GetPieces(caster, SET_MECH) - 1 ) )\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, target, dmg )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", target, \"origin\" ) )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", target, \"head\" ) )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", target, \"chest\" ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OldHealer takes nothing returns nothing\r\n    set gg_trg_OldHealer = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OldHealer, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OldHealer, Condition( function Trig_OldHealer_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OldHealer, function Trig_OldHealer_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}