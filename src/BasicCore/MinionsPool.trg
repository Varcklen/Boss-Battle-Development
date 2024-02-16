{
  "Id": 50332129,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MinionsPool_Conditions takes nothing returns boolean\r\n    return GetUnitName(GetDyingUnit()) != \"dummy\" and not( IsUnitType(GetDyingUnit(), UNIT_TYPE_ANCIENT ) ) and not( IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO ) )\r\nendfunction\r\n\r\nglobals\r\n    integer array deadminion[5][31]//игрок/лимит\r\n    integer array deadminionhp[5][31]//игрок/лимит\r\n    integer array deadminionat[5][31]//игрок/лимит\r\n    integer array deadminionnum[5]\r\n    integer array deadminionlim[5]\r\nendglobals\r\n\r\nfunction Trig_MinionsPool_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1\r\n    \r\n    if i < 5 and udg_combatlogic[i] then\r\n        set deadminionnum[i] = deadminionnum[i] + 1\r\n        if deadminionnum[i] > 30 then\r\n            set deadminionnum[i] = 1\r\n        endif\r\n        if deadminionlim[i] < 30 then\r\n            set deadminionlim[i] = deadminionlim[i] + 1\r\n        endif\r\n\r\n        set deadminion[i][deadminionnum[i]] = GetUnitTypeId(GetDyingUnit())\r\n        set deadminionhp[i][deadminionnum[i]] = BlzGetUnitMaxHP(GetDyingUnit())\r\n        set deadminionat[i][deadminionnum[i]] = BlzGetUnitBaseDamage(GetDyingUnit(), 0)\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MinionsPool takes nothing returns nothing\r\n    set gg_trg_MinionsPool = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MinionsPool, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_MinionsPool, Condition( function Trig_MinionsPool_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MinionsPool, function Trig_MinionsPool_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}