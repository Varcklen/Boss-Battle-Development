{
  "Id": 50332504,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Perfectly_Cut_LensCast_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0BL'\r\nendfunction\r\n\r\nfunction Trig_Perfectly_Cut_LensCast_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local real x\r\n    local real y\r\n    local real area\r\n    local real dmg\r\n    local integer arm\r\n    local integer i\r\n    local integer iEnd\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set x = GetLocationX( GetSpellTargetLoc() )\r\n        set y = GetLocationY( GetSpellTargetLoc() )\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set x = GetUnitX( caster ) + GetRandomReal( -650, 650 )\r\n        set y = GetUnitY( caster ) + GetRandomReal( -650, 650 )\r\n        call textst( udg_string[0] + GetObjectName('A0BL'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set x = GetLocationX( GetSpellTargetLoc() )\r\n        set y = GetLocationY( GetSpellTargetLoc() )\r\n    endif\r\n\r\n    set arm = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( \"pcln\" ) )\r\n    set dmg = RMaxBJ(100, arm)\r\n    set area = RMaxBJ(100, arm)\r\n\r\n    set i = 1\r\n    set iEnd = eyest(caster)\r\n    loop\r\n        exitwhen i > iEnd\r\n        call GroupAoE( caster, null, x, y, dmg, area, \"enemy\", \"\", \"Blink Blue Target.mdx\" )\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Perfectly_Cut_LensCast takes nothing returns nothing\r\n    set gg_trg_Perfectly_Cut_LensCast = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Perfectly_Cut_LensCast, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Perfectly_Cut_LensCast, Condition( function Trig_Perfectly_Cut_LensCast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Perfectly_Cut_LensCast, function Trig_Perfectly_Cut_LensCast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}