{
  "Id": 50333075,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope RandomLogicFizzle initializer init\r\n\r\n    globals\r\n        constant string RL_FIZZLE_EFFECT = \"Abilities\\\\Spells\\\\Other\\\\TalkToMe\\\\TalkToMe\"\r\n    endglobals\r\n    \r\n    private function Trig_RandomLogicFizzle_Conditions takes nothing returns boolean\r\n        return false\r\n    endfunction\r\n    \r\n    function Trig_RandomLogicFizzle_Actions takes nothing returns nothing\r\n        local unit caster\r\n        \r\n        if CastLogic() then\r\n            set caster = udg_Caster\r\n        elseif RandomLogic() then\r\n            set caster = udg_Caster\r\n        else\r\n            set caster = GetSpellAbilityUnit()\r\n        endif\r\n        \r\n        call textst( \"Fizzled!\", caster, 64, 90, 10, 1.5 )\r\n        call DestroyEffect( AddSpecialEffectTarget(RL_FIZZLE_EFFECT, caster, \"overhead\" ) )\r\n        set udg_RandomLogic = false\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_RandomLogicFizzle = CreateTrigger( )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_RandomLogicFizzle, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n        call TriggerAddCondition( gg_trg_RandomLogicFizzle, Condition( function Trig_RandomLogicFizzle_Conditions ) )\r\n        call TriggerAddAction( gg_trg_RandomLogicFizzle, function Trig_RandomLogicFizzle_Actions )\r\n    endfunction\r\n    \r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}