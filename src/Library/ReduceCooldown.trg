{
  "Id": 50332087,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ReduceCooldown\r\n\r\n    function UnitReduceCooldown takes unit u, real time returns nothing\r\n        local integer array a\r\n        local integer cyclA\r\n        local integer i = GetUnitUserData(u)\r\n        \r\n        if not(IsUnitInGroup(u, udg_heroinfo)) then\r\n            call BJDebugMsg(\"You are trying to reduce the cooldown of a \\\"\" + GetUnitName(u) + \"\\\" unit that is not a hero! Please report this error to the map author.\")\r\n            return\r\n        endif\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set a[cyclA] = 0\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[1][udg_HeroNum[i]]) > 0 then\r\n            set a[1] = Database_Hero_Abilities[1][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[2][udg_HeroNum[i]]) > 0 then\r\n            set a[2] = Database_Hero_Abilities[2][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[3][udg_HeroNum[i]]) > 0 then\r\n            set a[3] = Database_Hero_Abilities[3][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[4][udg_HeroNum[i]]) > 0 then\r\n            set a[4] = Database_Hero_Abilities[4][udg_HeroNum[i]]\r\n        endif\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if a[cyclA] != 0 then\r\n                if BlzGetUnitAbilityCooldownRemaining(u,a[cyclA]) > time then\r\n                    call BlzStartUnitAbilityCooldown( u, a[cyclA], RMaxBJ( 0.1,BlzGetUnitAbilityCooldownRemaining(u, a[cyclA]) - time) )\r\n                endif\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set a[cyclA] = 0\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n\r\n        set u = null\r\n    endfunction\r\n\r\n    function UnitReduceCooldownPercent takes unit u, real percent returns nothing\r\n        local integer array a\r\n        local integer cyclA\r\n        local integer i = GetUnitUserData(u)\r\n\r\n        if not(IsUnitInGroup(u, udg_heroinfo)) then\r\n            call BJDebugMsg(\"You are trying to reduce the cooldown of a \\\"\" + GetUnitName(u) + \"\\\" unit that is not a hero! Please report this error to the map author.\")\r\n            return\r\n        endif\r\n\r\n        if percent < 0 then\r\n            set percent = 0\r\n        endif\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set a[cyclA] = 0\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[1][udg_HeroNum[i]]) > 0 then\r\n            set a[1] = Database_Hero_Abilities[1][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[2][udg_HeroNum[i]]) > 0 then\r\n            set a[2] = Database_Hero_Abilities[2][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[3][udg_HeroNum[i]]) > 0 then\r\n            set a[3] = Database_Hero_Abilities[3][udg_HeroNum[i]]\r\n        endif\r\n        if GetUnitAbilityLevel( u, Database_Hero_Abilities[4][udg_HeroNum[i]]) > 0 then\r\n            set a[4] = Database_Hero_Abilities[4][udg_HeroNum[i]]\r\n        endif\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if a[cyclA] != 0 then\r\n                call BlzStartUnitAbilityCooldown( u, a[cyclA], RMaxBJ( 0.1,BlzGetUnitAbilityCooldownRemaining(u, a[cyclA]) * percent) )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set a[cyclA] = 0\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n\r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}