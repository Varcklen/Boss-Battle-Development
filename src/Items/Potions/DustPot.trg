{
  "Id": 50332821,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DustPot_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0KF'\r\nendfunction\r\n\r\nfunction DustPotCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local real counter = LoadReal( udg_hash, id, StringHash( \"dustt\" ) )\r\n    local real heal = LoadReal( udg_hash, id, StringHash( \"dust\" ) )\r\n    local unit u = LoadUnitHandle( udg_hash, id, StringHash( \"dust\" ) )\r\n    \r\n    if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then\r\n        set IsHealFromPotion = true\r\n        call healst( u, null, heal )\r\n    endif\r\n    \r\n    if counter > 1 and GetUnitState( u, UNIT_STATE_LIFE) > 0.405 and GetUnitAbilityLevel(u, 'B02J') > 0 then\r\n        call SaveReal( udg_hash, id, StringHash( \"dustt\" ), counter - 1 )\r\n    else\r\n        call UnitRemoveAbility( u, 'A0R9' )\r\n        call UnitRemoveAbility( u, 'B02J' )\r\n        call FlushChildHashtable( udg_hash, id )\r\n        call DestroyTimer( GetExpiredTimer() )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\nfunction Trig_DustPot_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit caster\r\n    local real heal\r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( \"|cf0FF20FF Dust\", caster, 64, 90, 10, 1.5 )\r\n        set t = 5\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set t = 5\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    set heal = 80 * udg_SpellDamagePotion[GetPlayerId( GetOwningPlayer( caster ) ) + 1]\r\n    call UnitAddAbility( caster, 'A0R9' )\r\n    call potionst( caster )\r\n    \r\n    if LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"dust\" ) ) == null then\r\n        call SaveTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"dust\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"dust\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"dust\" ), caster )\r\n    call SaveReal( udg_hash, id, StringHash( \"dust\" ), heal )\r\n    call SaveReal( udg_hash, id, StringHash( \"dustt\" ), t )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"dust\" ) ), 1, true, function DustPotCast )\r\n    \r\n    if BuffLogic() then\r\n        call effst( caster, caster, \"Trig_DustPot_Actions\", 1, t )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DustPot takes nothing returns nothing\r\n    set gg_trg_DustPot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DustPot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_DustPot, Condition( function Trig_DustPot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DustPot, function Trig_DustPot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}