{
  "Id": 50333282,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ShamanE_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0WR'\r\nendfunction\r\n\r\nfunction Trig_ShamanE_Actions takes nothing returns nothing\r\n    local integer lvl\r\n    local unit caster\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local real x\r\n    local real y\r\n    local real t\r\n    local real j\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        set x = GetLocationX( GetSpellTargetLoc() )\r\n        set y = GetLocationY( GetSpellTargetLoc() )\r\n        set t = 3 + (2*lvl)\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0WR'), caster, 64, 90, 10, 1.5 )\r\n        set x = GetUnitX( caster ) + GetRandomReal( -650, 650 )\r\n        set y = GetUnitY( caster ) + GetRandomReal( -650, 650 )\r\n        set t = 3 + (2*lvl)\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n        set x = GetLocationX( GetSpellTargetLoc() )\r\n        set y = GetLocationY( GetSpellTargetLoc() )\r\n        set t = 3 + (2*lvl)\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    call GroupEnumUnitsInRange( g, x, y, 400, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        set j = t\r\n        if unitst( u, caster, \"enemy\" ) then\r\n            if IsUnitType( u, UNIT_TYPE_ANCIENT) then\r\n                set j = j/3\r\n            endif\r\n            call UnitPoly( caster, u, 'n02N', j )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ShamanE takes nothing returns nothing\r\n    set gg_trg_ShamanE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ShamanE, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ShamanE, Condition( function Trig_ShamanE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ShamanE, function Trig_ShamanE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}