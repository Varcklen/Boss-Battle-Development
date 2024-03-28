{
  "Id": 50332628,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope MiracleWall initializer init\r\n\t\r\n\tglobals\r\n\t\tpublic trigger Trigger = null\r\n\t\t\r\n\t\tprivate constant integer ITEM_ID = 'I03Z'\r\n\tendglobals\r\n\t\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return luckylogic( AfterAttack.TargetUnit, 8, 1, 100 ) and combat( AfterAttack.TargetUnit, false, 0 )\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster = AfterAttack.GetDataUnit(\"target\")\r\n\t    local integer rand = GetRandomInt( 1, 3 )\r\n\t    \r\n\t    if rand == 1 then\r\n\t        call CastRandomAbility(caster, 1, udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n\t    elseif rand == 2 then\r\n\t        call CastRandomAbility(caster, 1, udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[15])] )\r\n\t    else\r\n\t        call CastRandomAbility(caster, 1, udg_DB_Trigger_Three[GetRandomInt( 1, udg_Database_NumberItems[16])] )\r\n\t    endif\r\n\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\tpublic function Enable takes nothing returns nothing\r\n\t\t\r\n    endfunction\r\n    \r\n    public function Disable takes nothing returns nothing\r\n\t\t\r\n    endfunction\r\n    \r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, \"target\" )\r\n\tendfunction\r\n\t\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}