{
  "Id": 50332066,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DeathLib requires TextLib\r\n\r\n    //Is unit can be target of battle ressurect\r\n    function DeathIf takes unit u returns boolean\r\n        local boolean l = false\r\n        if GetUnitAbilityLevel(u, 'A05X') == 0 and not( IsUnitInGroup(u, udg_Return) ) and udg_Heroes_Ressurect_Battle <= 0 and IsUnitInGroup( u, udg_otryad ) then\r\n            set l = true\r\n        endif\r\n        set u = null\r\n        return l\r\n    endfunction\r\n\r\n    function IsUnitAlive takes unit myUnit returns boolean\r\n        local boolean isWork = false\r\n        if GetUnitState( myUnit, UNIT_STATE_LIFE) > 0.405 then\r\n            set isWork = true\r\n        endif\r\n        set myUnit = null\r\n        return isWork\r\n    endfunction\r\n\r\n    function IsUnitDead takes unit myUnit returns boolean\r\n        local boolean isWork = false\r\n        if GetUnitState( myUnit, UNIT_STATE_LIFE) <= 0.405 then\r\n            set isWork = true\r\n        endif\r\n        set myUnit = null\r\n        return isWork\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}