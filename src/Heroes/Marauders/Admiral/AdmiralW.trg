{
  "Id": 50333147,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AdmiralW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0RZ' and ( combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_AdmiralW_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer g\r\n    local integer lvl\r\n    local unit caster\r\n    local real heal\r\n    local real bonus\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0RZ'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId() )\r\n    endif\r\n\r\n    set g = 15 + ( 5 * lvl )\r\n    set bonus = 0.05 + ( lvl * 0.03 )\r\n\r\n    if GetPlayerState(GetOwningPlayer( caster ), PLAYER_STATE_RESOURCE_GOLD) >= g then\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 and IsUnitAlly( udg_hero[cyclA], GetOwningPlayer( caster ) ) then\r\n                call healst( caster, udg_hero[cyclA], GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_LIFE) * bonus )\r\n                call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\", GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ) ) )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        call SetPlayerState( GetOwningPlayer( caster ), PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( GetOwningPlayer( caster ), PLAYER_STATE_RESOURCE_GOLD) - g ) )\r\n    elseif GetSpellAbilityId() == 'A0RZ' then\r\n        call textst( \"NOT ENOUGH GOLD\", caster, 64, 90, 10, 1.5 )\t\r\n    endif\r\n\r\n\tset caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AdmiralW takes nothing returns nothing\r\n    set gg_trg_AdmiralW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_AdmiralW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_AdmiralW, Condition( function Trig_AdmiralW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AdmiralW, function Trig_AdmiralW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}