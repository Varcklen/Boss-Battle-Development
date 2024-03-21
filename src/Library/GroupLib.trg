{
  "Id": 50332064,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library GroupLib requires DummyspawnLib, UnitstLib\r\n\r\n\tglobals\r\n\t\tprivate group temp_group = CreateGroup()\r\n\tendglobals\r\n\r\n    function GroupAoE takes unit caster, real x, real y, real dmg, real area, string who, string animationCenter, string animationUnit returns group\r\n        local group g = CreateGroup()\r\n        local unit u\r\n\r\n        if x == 0 and y == 0 then\r\n            set x = GetUnitX(caster)\r\n            set y = GetUnitY(caster)\r\n        endif\r\n        \r\n        if animationCenter != null then\r\n            call DestroyEffect( AddSpecialEffect( animationCenter, x, y ) )\r\n        endif\r\n\r\n        call GroupClear( temp_group )\r\n        call GroupEnumUnitsInRange( g, x, y, area, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if unitst( u, caster, who ) then\r\n                if animationUnit != null then\r\n                    call DestroyEffect( AddSpecialEffect( animationUnit, GetUnitX(u), GetUnitY(u) ) )\r\n                endif\r\n                call UnitTakeDamage( caster, u, dmg, DAMAGE_TYPE_MAGIC )\r\n                call GroupAddUnit(temp_group,u)\r\n            endif\r\n            call GroupRemoveUnit(g,u)\r\n        endloop\r\n        \r\n        call DestroyGroup( g )\r\n        set u = null\r\n        set g = null\r\n        return temp_group\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}