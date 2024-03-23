{
  "Id": 50332074,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TimebonusLib requires SetCount\r\n\r\n    function timebonus takes unit u, real r returns real\r\n        local real t = r\r\n        local integer i = GetUnitUserData(u)\r\n        \r\n        call ChangeBuffDuration.SetDataUnit(\"caster\", u)\r\n\t    call ChangeBuffDuration.SetDataReal(\"new_value\", t)\r\n\t    call ChangeBuffDuration.SetDataReal(\"static_value\", t)\r\n\t    call ChangeBuffDuration.Invoke()\r\n\t    \r\n\t    set t = ChangeBuffDuration.GetDataReal(\"new_value\")\r\n        \r\n        set t = t + (udg_RandomBonus_BuffDuration[i]*r)\r\n\r\n        set u = null\r\n        return t\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}