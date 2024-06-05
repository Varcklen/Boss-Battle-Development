{
  "Id": 50332096,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Lightning\r\n\r\n    globals\r\n        private lightning TempLightning = null\r\n    endglobals\r\n\r\n    private function End takes nothing returns nothing\r\n        local integer id = GetHandleId( GetExpiredTimer() )\r\n        call DestroyLightning( LoadLightningHandle( udg_hash, id, StringHash( \"light\" ) ) )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    endfunction\r\n\r\n    public function CreateLightning takes string lightningType, real xStart, real yStart, real zStart, real xEnd, real yEnd, real zEnd, real lifeTime returns lightning\r\n        local timer timerUsed = CreateTimer()\r\n    \r\n        set TempLightning = AddLightningEx(lightningType, true, xStart, yStart, zStart, xEnd, yEnd, zEnd )\r\n                \r\n        call SaveTimerHandle( udg_hash, GetHandleId( TempLightning ), StringHash( \"light\" ), timerUsed )\r\n        call SaveLightningHandle( udg_hash, GetHandleId( timerUsed ), StringHash( \"light\" ), TempLightning )\r\n        call TimerStart( timerUsed, lifeTime, false, function End )\r\n        \r\n        set timerUsed = null\r\n        return TempLightning\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}