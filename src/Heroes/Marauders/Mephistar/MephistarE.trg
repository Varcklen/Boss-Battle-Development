{
  "Id": 50333175,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MephistarE_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0ZK'\r\nendfunction\r\n\r\nfunction Trig_MephistarE_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetLearningUnit())) + 1\r\n    local integer cyclA\r\n    \r\n    set udg_Mephistar = GetLearningUnit()\r\n    \r\n    if GetLocalPlayer() == GetOwningPlayer( GetLearningUnit() ) then\r\n        call BlzFrameSetVisible( mephuse, true )\r\n    endif\r\n    \r\n    set cyclA = 1\r\n    loop\r\n        exitwhen cyclA > 9\r\n        if udg_MephistarUse[cyclA] > 0 then\r\n            call BlzFrameSetTexture( mephicon[cyclA], BlzGetAbilityIcon( udg_DB_SoulContract_Set[cyclA]), 0, true )\r\n        else\r\n            call BlzFrameSetTexture( mephicon[cyclA], \"ReplaceableTextures\\\\CommandButtons\\\\BTNCancel.blp\", 0, true )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MephistarE takes nothing returns nothing\r\n    set gg_trg_MephistarE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MephistarE, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_MephistarE, Condition( function Trig_MephistarE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MephistarE, function Trig_MephistarE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}