{
  "Id": 50332618,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer JAGOT_COOLDOWN_REDUCTION = 4\r\n    constant integer JAGOT_CLOCK_ID = 'I0GJ'\r\n    \r\n    constant string JAGOT_ANIMATION = \"war3mapImported\\\\TimeUpheaval.mdl\"\r\nendglobals\r\n\r\nfunction Trig_Jagot_Conditions takes nothing returns boolean\r\n    return /*inv( GetSpellAbilityUnit(), 'I0GI' ) > 0 and*/ GetSpellAbilityId() == Database_Hero_Abilities[1][udg_HeroNum[GetUnitUserData(GetSpellAbilityUnit())]]\r\nendfunction\r\n\r\nfunction Trig_Jagot_Actions takes nothing returns nothing\r\n    local unit caster = GetSpellAbilityUnit()\r\n\r\n    set bj_lastCreatedItem = CreateItem( JAGOT_CLOCK_ID, Math_GetUnitRandomX(caster, 200), Math_GetUnitRandomY(caster, 200) )\r\n    call DestroyEffect( AddSpecialEffect( JAGOT_ANIMATION, GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Jagot takes nothing returns nothing\r\n    /*set gg_trg_Jagot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Jagot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Jagot, Condition( function Trig_Jagot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Jagot, function Trig_Jagot_Actions )*/\r\n    \r\n    call RegisterDuplicatableItemType('I0GI', EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_Jagot_Actions, function Trig_Jagot_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}