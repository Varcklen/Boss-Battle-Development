{
  "Id": 50332779,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope IkarosMudstone initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ITEM_ID = 'I03H' \r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return udg_fightmod[3] == false\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local integer i = 1\r\n\t    loop\r\n\t        exitwhen i > 4\r\n\t        if udg_hero[i] != null then\r\n\t            call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\Rock Slam.mdx\", udg_hero[i], \"origin\") )\r\n\t            if BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 1 then\r\n\t                call statst( udg_hero[i], 3, 0, 0, 0, true )\r\n\t            elseif BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 2  then\r\n\t                call statst( udg_hero[i], 0, 0, 3, 0, true )\r\n\t            elseif BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 3  then\r\n\t                call statst( udg_hero[i], 0, 3, 0, 0, true )\r\n\t            endif\r\n\t        endif\r\n\t        set i = i + 1\r\n\t    endloop\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t\tcall RegisterDuplicatableItemTypeCustom( ITEM_ID, \"udg_FightStart_Real\", function action, function condition)\r\n\t    /*set gg_trg_Ikaros_Mudstone = CreateTrigger(  )\r\n\t    call TriggerRegisterVariableEvent( gg_trg_Ikaros_Mudstone, \"udg_FightStart_Real\", EQUAL, 1.00 )\r\n\t    call TriggerAddCondition( gg_trg_Ikaros_Mudstone, Condition( function Trig_Ikaros_Mudstone_Conditions ) )\r\n\t    call TriggerAddAction( gg_trg_Ikaros_Mudstone, function Trig_Ikaros_Mudstone_Actions )*/\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}