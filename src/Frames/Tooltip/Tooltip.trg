{
  "Id": 50332275,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Tooltip initializer init \r\n    globals\r\n        framehandle TooltipName = null\r\n        framehandle TooltipDescription = null\r\n        framehandle TooltipBackdrop = null\r\n        \r\n        private constant real TOOLTIP_RETREAT = 0.01\r\n        private constant real TOOLTIP_NAME_SIZE = 1.25\r\n        private constant real TOOLTIP_NAME_RETREAT = TOOLTIP_NAME_SIZE*0.008\r\n        \r\n        private constant string TOOLTIP_NAME_COLOR = \"|cffffcc00\"\r\n        \r\n        private trigger TempTrigger = null\r\n    endglobals\r\n    \r\n    public function SetLocalTooltipText takes player localPlayer, string newName, string newDescription returns nothing \r\n        if GetLocalPlayer() == localPlayer then\r\n            call BlzFrameSetText( TooltipName, TOOLTIP_NAME_COLOR + newName + \"|r\" )\r\n            call BlzFrameSetText( TooltipDescription, newDescription )\r\n\r\n            call BlzFrameSetPoint(TooltipBackdrop, FRAMEPOINT_BOTTOMLEFT, TooltipDescription, FRAMEPOINT_BOTTOMLEFT, -TOOLTIP_RETREAT, -TOOLTIP_RETREAT)\r\n            call BlzFrameSetPoint(TooltipBackdrop, FRAMEPOINT_TOPRIGHT, TooltipDescription, FRAMEPOINT_TOPRIGHT, TOOLTIP_RETREAT, TOOLTIP_RETREAT + (2*TOOLTIP_NAME_RETREAT))\r\n        endif\r\n        set localPlayer = null\r\n    endfunction\r\n    \r\n    private function TooltipDisable takes nothing returns nothing \r\n        if GetLocalPlayer() == GetTriggerPlayer() then\r\n            call BlzFrameSetVisible( TooltipBackdrop, false )\r\n        endif\r\n    endfunction\r\n\r\n    private function TooltipEnable takes nothing returns nothing \r\n        if GetLocalPlayer() == GetTriggerPlayer() then\r\n            call BlzFrameSetVisible( TooltipBackdrop, true )\r\n        endif\r\n    endfunction\r\n\r\n    public function AddEvent takes framehandle frameToAdd, code codeEnter returns trigger\r\n        local trigger trigExit = CreateTrigger()\r\n        \r\n        set TempTrigger = CreateTrigger()\r\n        call BlzTriggerRegisterFrameEvent(TempTrigger, frameToAdd, FRAMEEVENT_MOUSE_ENTER)\r\n        call TriggerAddAction( TempTrigger, codeEnter )\r\n        call TriggerAddAction( TempTrigger, function TooltipEnable )\r\n        \r\n        call BlzTriggerRegisterFrameEvent(trigExit, frameToAdd, FRAMEEVENT_MOUSE_LEAVE)\r\n        call TriggerAddAction( trigExit, function TooltipDisable )\r\n        \r\n        set frameToAdd = null\r\n        set codeEnter = null\r\n        set trigExit = null\r\n        return TempTrigger\r\n    endfunction\r\n    \r\n    public function AddMouseEvent takes framehandle frameToAdd, code codeEnter, code codeUse, integer index returns trigger\r\n        \r\n        set TempTrigger = CreateTrigger()\r\n        call BlzTriggerRegisterFrameEvent(TempTrigger, frameToAdd, FRAMEEVENT_CONTROL_CLICK) \r\n        call TriggerAddAction(TempTrigger, codeUse)\r\n        call Tooltip_AddEvent(frameToAdd, codeEnter )\r\n        call SaveInteger(udg_hash, GetHandleId(frameToAdd), StringHash(\"index\"), index )\r\n        \r\n        return TempTrigger\r\n     endfunction\r\n\r\n    private function init takes nothing returns nothing \r\n        set TooltipBackdrop = BlzCreateFrame( \"QuestButtonBaseTemplate\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0), 0, 0 )\r\n        call BlzFrameSetVisible( TooltipBackdrop, false )\r\n        call BlzFrameSetLevel( TooltipBackdrop, 1 )\r\n        \r\n        set TooltipName = BlzCreateFrameByType(\"TEXT\", \"\",  TooltipBackdrop, \"StandartFrameTemplate\", 0)\r\n        call BlzFrameSetPoint( TooltipName, FRAMEPOINT_TOPLEFT, TooltipBackdrop, FRAMEPOINT_TOPLEFT, TOOLTIP_RETREAT/TOOLTIP_NAME_SIZE,-0.01) \r\n        call BlzFrameSetScale(TooltipName, TOOLTIP_NAME_SIZE)\r\n\r\n        set TooltipDescription = BlzCreateFrameByType(\"TEXT\", \"\",  TooltipBackdrop, \"StandartFrameTemplate\", 0)\r\n        call BlzFrameSetSize(TooltipDescription, 0.3, 0)\r\n        call BlzFrameSetAbsPoint(TooltipDescription, FRAMEPOINT_BOTTOMRIGHT, 0.78, 0.16)\r\n    endfunction\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}