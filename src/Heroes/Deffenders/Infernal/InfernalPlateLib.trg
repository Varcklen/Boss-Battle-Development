{
  "Id": 50333030,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library InfernalPlateLib requires TextLib\r\n\r\nfunction platest takes unit u, integer i returns nothing\r\n\tlocal integer g = GetUnitAbilityLevel(u, 'A1A6')\r\n    local integer lvl = GetUnitAbilityLevel(u, 'A1A5')\r\n    local integer lim = lvl+3\r\n    local integer k\r\n\r\n    if IsUnitType( u, UNIT_TYPE_HERO) and lvl > 0 then\r\n        if g + i > lim then\r\n            set g = lim\r\n        elseif g + i < 1 then\r\n            set g = 1\r\n        else\r\n            set g = g + i\r\n        endif\r\n        call SetUnitAbilityLevel(u, 'A1A6', g )\r\n        if GetUnitAbilityLevel(u, 'A1A6') == 1 and GetUnitAbilityLevel(u, 'A1A7') > 0 then\r\n            call UnitRemoveAbility( u, 'A1A7')\r\n        elseif GetUnitAbilityLevel(u, 'A1A6') > 1 and GetUnitAbilityLevel(u, 'A1A7') == 0 then\r\n            call UnitAddAbility( u, 'A1A7')\r\n        endif\r\n\r\n        call textst( \"|cFF57E5C6\" + I2S(g-1), u, 64, GetRandomReal( 80, 100 ), 12, 1 )\r\n        if i < 0 then\r\n            set i = -1*i\r\n        endif\r\n    endif\r\nendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}