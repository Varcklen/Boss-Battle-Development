{
  "Id": 50332449,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Goat_Dragon_Claw_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and combat( udg_DamageEventSource, false, 0 ) and luckylogic( udg_DamageEventSource, 10, 1, 100 ) and ( inv( udg_DamageEventSource, 'I0GA') > 0 or ( inv( udg_DamageEventSource, 'I030') > 0 and udg_Set_Weapon_Logic[GetPlayerId(GetOwningPlayer(udg_DamageEventSource)) + 1 + 108] ) )\r\nendfunction\r\n\r\nfunction Trig_Goat_Dragon_Claw_Actions takes nothing returns nothing\r\n    local unit u = udg_hero[GetPlayerId(GetOwningPlayer(udg_DamageEventSource)) + 1]\r\n    local integer id = GetHandleId( u )\r\n    local integer k = LoadInteger( udg_hash, id, StringHash( \"dgca\" ) )\r\n    local integer i = GetPlayerId(GetOwningPlayer(u)) + 1\r\n    \r\n    if k < 10 then\r\n        call UnitAddAbility( u, 'A1AH' )\r\n        set k = k + 1\r\n        call SaveInteger( udg_hash, id, StringHash( \"dgca\" ), k )\r\n        call SpellUniqueUnit(u, 20)\r\n        call textst( \"|cff60C445 +\" + I2S(k*20) + \"%\", u, 64, 90, 10, 1 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Goat_Dragon_Claw takes nothing returns nothing\r\n    set gg_trg_Goat_Dragon_Claw = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Goat_Dragon_Claw, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Goat_Dragon_Claw, Condition( function Trig_Goat_Dragon_Claw_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Goat_Dragon_Claw, function Trig_Goat_Dragon_Claw_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}