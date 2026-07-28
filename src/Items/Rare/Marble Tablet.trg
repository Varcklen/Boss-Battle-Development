{
  "Id": 50332667,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope MarbleTablet initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ITEM_ID = 'I076'\r\n\t\tprivate constant integer SPELL_POWER_GAIN = 7\r\n\t\tprivate constant integer LUCK_GAIN = 7\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t\treturn udg_fightmod[3] == false\r\n\tendfunction\r\n\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal unit caster = BattleEnd.GetDataUnit(\"caster\")\r\n\t\tlocal integer index = BattleEnd.GetDataInteger(\"index\")\r\n\r\n        call spdst( caster, SPELL_POWER_GAIN )\r\n        call luckyst( caster, LUCK_GAIN )\r\n        call textst( \"|c00ffffff +\" + I2S(SPELL_POWER_GAIN) + \"% Spell Power and +\" + I2S(LUCK_GAIN) + \" Luck\", caster, 64, GetRandomReal( 0, 360 ), 10, 1.5 )\r\n        set udg_Data[index + 276] = udg_Data[index + 276] + SPELL_POWER_GAIN\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\tprivate function init takes nothing returns nothing\r\n\t    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )\r\n\tendfunction\r\n\t\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}