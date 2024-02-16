{
  "Id": 50333057,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Quest requires TextLib, SpecialEffect\r\n\r\n    globals\r\n        private constant string ANIMATION_COMPLETE = \"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\"\r\n    endglobals\r\n\r\n    private function CompletedActions takes unit caster, integer questItemRawCode, integer rewardRawCode returns nothing\r\n        local item questItem = GetItemOfTypeFromUnitBJ( caster, questItemRawCode)\r\n    \r\n        call textst( GetItemName(questItem) + \" completed!\", caster, 64, GetRandomReal( 45, 135 ), 12, 1.5 )\r\n        call RemoveItem(questItem)\r\n        call UnitAddItem(caster, CreateItem( rewardRawCode, GetUnitX(caster), GetUnitY(caster)))\r\n        call PlaySpecialEffect(ANIMATION_COMPLETE, caster)\r\n        set udg_QuestDone[GetUnitUserData(caster)] = true\r\n        \r\n        set questItem = null\r\n        set caster = null\r\n    endfunction\r\n    \r\n    public function QuestCondition takes unit caster, integer questItem, integer reward, integer currentCount, integer countNeeded returns boolean\r\n        local boolean isCompleted = false\r\n        \r\n        if currentCount >= countNeeded then\r\n            call CompletedActions(caster, questItem, reward)\r\n            set isCompleted = true\r\n        else\r\n            call textst( \"|c00ffffff \" + I2S(currentCount) + \"/\" + I2S(countNeeded), caster, 64, GetRandomReal( 45, 135 ), 8, 1.5 )\r\n        endif\r\n        \r\n        set caster = null\r\n        return isCompleted\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}