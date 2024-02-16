{
  "Id": 50332064,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library GroupLib requires DummyspawnLib, UnitstLib\r\n\r\n    function GroupAoE takes unit caster, unit dummy, real x, real y, real dmg, real area, string who, string strall, string str returns group\r\n        local group g = CreateGroup()\r\n        local unit u\r\n        local unit dum\r\n        local real xc\r\n        local real yc\r\n\r\n        if x == 0 and y == 0 then\r\n            set xc = GetUnitX(caster)\r\n            set yc = GetUnitY(caster)\r\n        else\r\n            set xc = x\r\n            set yc = y\r\n        endif\r\n        \r\n        if strall != \"\" and strall != null then\r\n            call DestroyEffect( AddSpecialEffect( strall, xc, yc ) )\r\n        endif\r\n        /*if dummy == null then\r\n            set dum = dummyspawn( caster, 1, 0, 0, 0 )\r\n        else\r\n            set dum = dummy\r\n        endif*/\r\n        call GroupClear( udg_Temp_Group )\r\n        call GroupEnumUnitsInRange( g, xc, yc, area, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if unitst( u, caster, who ) then\r\n                if str != \"\" and str != null then\r\n                    call DestroyEffect( AddSpecialEffect( str, GetUnitX(u), GetUnitY(u) ) )\r\n                endif\r\n                call UnitTakeDamage( caster, u, dmg, DAMAGE_TYPE_MAGIC )\r\n                call GroupAddUnit(udg_Temp_Group,u)\r\n            endif\r\n            call GroupRemoveUnit(g,u)\r\n        endloop\r\n        \r\n        call GroupClear( g )\r\n        call DestroyGroup( g )\r\n        set u = null\r\n        set g = null\r\n        set caster = null\r\n        set dum = null\r\n        set dummy = null\r\n        \r\n        return udg_Temp_Group\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}