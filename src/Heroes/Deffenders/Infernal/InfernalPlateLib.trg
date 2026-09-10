{
  "Id": 50333030,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library InfernalPlateLib requires TextLib\r\n\r\n\tfunction platest takes unit u, integer i returns nothing\r\n\t\tlocal integer g = GetUnitAbilityLevel(u, 'A1A6')\r\n\t    local integer lvl = GetUnitAbilityLevel(u, 'A1A5')\r\n\t    local integer lim = lvl+3\r\n\t    local integer k\r\n\t\r\n\t    if IsUnitType( u, UNIT_TYPE_HERO) and lvl > 0 then\r\n\t        if g + i > lim then\r\n\t            set g = lim\r\n\t        elseif g + i < 1 then\r\n\t            set g = 1\r\n\t        else\r\n\t            set g = g + i\r\n\t        endif\r\n\t        call SetUnitAbilityLevel(u, 'A1A6', g )\r\n\t        if GetUnitAbilityLevel(u, 'A1A6') == 1 and GetUnitAbilityLevel(u, 'A1A7') > 0 then\r\n\t            call UnitRemoveAbility( u, 'A1A7')\r\n\t        elseif GetUnitAbilityLevel(u, 'A1A6') > 1 and GetUnitAbilityLevel(u, 'A1A7') == 0 then\r\n\t            call UnitAddAbility( u, 'A1A7')\r\n\t        endif\r\n\t\r\n\t        call textst( \"|cFF57E5C6\" + I2S(g-1), u, 64, GetRandomReal( 80, 100 ), 12, 1 )\r\n\t        if i < 0 then\r\n\t            set i = -1*i\r\n\t        endif\r\n\t    endif\r\n\tendfunction\r\n\t\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}