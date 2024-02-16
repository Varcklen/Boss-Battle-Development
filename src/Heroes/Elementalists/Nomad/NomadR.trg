{
  "Id": 50333272,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_NomadR_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A04U' and GetUnitAbilityLevel(GetLearningUnit(), 'A04U') == 1\r\nendfunction\r\n\r\nfunction Trig_NomadR_Actions takes nothing returns nothing\r\n    \tlocal integer id = GetHandleId( GetLearningUnit() )\r\n\r\n\tif GetLocalPlayer() == GetOwningPlayer(GetLearningUnit()) then\r\n    \t\tcall BlzFrameSetVisible( shamanframe, true )\r\n\tendif\r\n\tcall BallEnergy( GetLearningUnit(), -3 )\r\n\r\n    \tif LoadTimerHandle( udg_hash, id, StringHash( \"nmdr\" ) ) == null  then\r\n        \tcall SaveTimerHandle( udg_hash, id, StringHash( \"nmdr\" ), CreateTimer() )\r\n    \tendif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"nmdr\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"nmdr\" ), GetLearningUnit() )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetLearningUnit() ), StringHash( \"nmdr\" ) ), 3.5, true, function NomadRCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_NomadR takes nothing returns nothing\r\n    set gg_trg_NomadR = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_NomadR, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_NomadR, Condition( function Trig_NomadR_Conditions ) )\r\n    call TriggerAddAction( gg_trg_NomadR, function Trig_NomadR_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}