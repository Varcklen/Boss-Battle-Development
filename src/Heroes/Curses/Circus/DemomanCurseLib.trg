{
  "Id": 50333339,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DemomanCurseLib requires TimePlayLib, TimebonusLib, BuffsLibLib\r\n\r\nfunction DemomanCurse takes unit caster, unit target returns nothing\r\n    local integer array k\r\n    local integer rand\r\n    local integer i\r\n    local integer cyclA\r\n    local real t\r\n    \r\n    set cyclA = 1\r\n    set i = 0\r\n    loop\r\n        exitwhen cyclA > 4\r\n        set k[cyclA] = 0\r\n        if GetUnitAbilityLevel( target, 'A1A0' + cyclA) == 0 then\r\n            set i = i + 1\r\n            set k[i] = cyclA\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set t = timebonus(caster, 15)\r\n    if i > 0 then\r\n        set rand = k[GetRandomInt(1, i)]\r\n        call bufst( caster, target, 'A1A0' + rand, 'B1B0' + rand, \"demc\" + I2S( rand ), t )\r\n    endif\r\nendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}