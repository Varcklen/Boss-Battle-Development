{
  "Id": 50332673,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Shadow_gem_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A11I'\r\nendfunction\r\n\r\nfunction Trig_Shadow_gem_Actions takes nothing returns nothing\r\n    local integer x\r\n    local integer cyclA = 1\r\n    local unit caster\r\n    local real sh\r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A11I'), caster, 64, 90, 10, 1.5 )\r\n        set t = 60\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set t = 60\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    set x = eyest( caster )\r\n    if IsUnitType( caster, UNIT_TYPE_HERO) or IsUnitType( caster, UNIT_TYPE_ANCIENT) then\r\n        set sh = GetUnitState( caster, UNIT_STATE_LIFE) - ( GetUnitState( caster, UNIT_STATE_MAX_LIFE) * 0.1 )\r\n        call SetUnitState( caster, UNIT_STATE_LIFE, GetUnitState( caster, UNIT_STATE_MAX_LIFE) * 0.1 )\r\n        call shield( caster, caster, sh, t )\r\n        if BuffLogic() then\r\n            call effst( caster, caster, \"Trig_Shadow_gem_Actions\", 1, t )\r\n        endif\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Shadow_gem takes nothing returns nothing\r\n    set gg_trg_Shadow_gem = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Shadow_gem, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Shadow_gem, Condition( function Trig_Shadow_gem_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Shadow_gem, function Trig_Shadow_gem_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}