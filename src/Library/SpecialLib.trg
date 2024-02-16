{
  "Id": 50332104,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library SpecialLib\r\n\r\n    function NewSpecial takes unit caster, integer spec returns nothing\r\n        local player p = GetOwningPlayer(caster)\r\n        local integer i = GetUnitUserData(caster)\r\n        local integer spold = udg_Ability_Spec[i]\r\n\r\n        /*if spold == 'A1BK' then\r\n            if GetLocalPlayer() == p then\r\n                call BlzFrameSetVisible( dualtext, false )\r\n            endif\r\n        endif*/\r\n        \r\n        call UnitRemoveAbility( caster, spold )\r\n        set udg_Ability_Spec[i] = spec\r\n        call UnitAddAbility( caster, spec )\r\n\r\n        /*if spec == 'A1BK' then\r\n            call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( \"dualch\" ), 3 )\r\n            if GetLocalPlayer() == p then\r\n                call BlzFrameSetText( dualtext, \"3\" )\r\n            endif\r\n        endif*/\r\n\r\n        if spec != 0 then\r\n            call BlzFrameSetVisible( specframe[i],true)\r\n            call BlzFrameSetTexture( specframe[i], BlzGetAbilityIcon(spec),0, true)\r\n        else\r\n            call BlzFrameSetVisible( specframe[i],false)\r\n        endif\r\n\r\n        set caster = null\r\n        set p = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}