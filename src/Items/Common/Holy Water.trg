{
  "Id": 50332492,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Holy_Water_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0G4'\r\nendfunction\r\n\r\nfunction Trig_Holy_Water_Actions takes nothing returns nothing\r\n    local integer cyclA\r\n    local item myItem\r\n    local unit caster = GetSpellAbilityUnit()\r\n\r\n    set cyclA = 0\r\n    loop\r\n        exitwhen cyclA > 5\r\n        set myItem = UnitItemInSlot( caster, cyclA )\r\n        if GetSpellTargetItem() == myItem then\r\n            call statst( caster, 1, 1, 1, 0, true )\r\n            call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\" , caster, \"origin\" ) )\r\n            call BlzSetItemExtendedTooltip( myItem, wordscurrent( caster, BlzGetItemExtendedTooltip(myItem), \"|cffC71585Cursed|r\", \"|cFF1CE6B9Cleaned!|r\" ) )\r\n            call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, 'I041') )\r\n            set cyclA = 5\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set myItem = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Holy_Water takes nothing returns nothing\r\n    set gg_trg_Holy_Water = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Holy_Water, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Holy_Water, Condition( function Trig_Holy_Water_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Holy_Water, function Trig_Holy_Water_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}