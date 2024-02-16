{
  "Id": 50333225,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_RealBroBonnyCopy_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( CreateUnitCopy_Original ) == 'n030'\r\nendfunction\r\n\r\nfunction Trig_RealBroBonnyCopy_Actions takes nothing returns nothing\r\n    local unit owner = LoadUnitHandle( udg_hash, GetHandleId( CreateUnitCopy_Original ), StringHash( \"rlbqac\" ) )\r\n    \r\n    call SaveUnitHandle( udg_hash, GetHandleId( CreateUnitCopy_Copy ), StringHash( \"rlbqac\" ), owner )\r\n\r\n    if GetUnitAbilityLevel( CreateUnitCopy_Original, 'A1BA') > 0 then\r\n        call BunnyAddAbilities(owner, CreateUnitCopy_Copy, 1)\r\n    endif\r\n    if GetUnitAbilityLevel( CreateUnitCopy_Original, 'A1B9') > 0 then\r\n        call BunnyAddAbilities(owner, CreateUnitCopy_Copy, 2)\r\n    endif\r\n    if GetUnitAbilityLevel( CreateUnitCopy_Original, 'A1BB') > 0 then\r\n        call BunnyAddAbilities(owner, CreateUnitCopy_Copy, 3)\r\n    endif\r\n    if GetUnitAbilityLevel( CreateUnitCopy_Original, 'A1BC') > 0 then\r\n        call BunnyAddAbilities(owner, CreateUnitCopy_Copy, 4)\r\n    endif\r\n    \r\n    set owner = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_RealBroBonnyCopy takes nothing returns nothing\r\n    set gg_trg_RealBroBonnyCopy = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_RealBroBonnyCopy, \"CreateUnitCopy_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_RealBroBonnyCopy, Condition( function Trig_RealBroBonnyCopy_Conditions ) )\r\n    call TriggerAddAction( gg_trg_RealBroBonnyCopy, function Trig_RealBroBonnyCopy_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}