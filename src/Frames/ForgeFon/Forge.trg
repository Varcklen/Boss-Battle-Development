{
  "Id": 50332310,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Forge\r\n\r\nfunction forge takes unit caster, item it, integer it1, integer it2, integer it3, boolean dest returns nothing\r\n\tlocal integer cyclA\r\n\tlocal item array forgetarget\r\n\tlocal string text\r\n\tlocal player p = GetOwningPlayer( caster )\r\n\tlocal integer i = GetPlayerId(p)\r\n\tlocal real k\r\n\tlocal integer array itd\r\n\tlocal integer id = GetHandleId(it) \r\n\tlocal integer j = i*3\r\n\r\n    set cyclA = 1\r\n    loop\r\n        exitwhen cyclA > 3\r\n        set forgetarget[cyclA] = null\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    if it1 != null or it2 != null or it3 != null then//\r\n        call BlzFrameSetVisible(itemfon, false)\r\n        call BlzFrameSetVisible(unitfon, false)\r\n        \r\n        set itd[j+1] = it1\r\n        set itd[j+2] = it2\r\n        set itd[j+3] = it3\r\n        \r\n        if udg_combatlogic[i+1] then\r\n            call BlzFrameSetAbsPoint(forgebut, FRAMEPOINT_CENTER, 0.4, 0.15)\r\n        else\r\n            call BlzFrameSetAbsPoint(forgebut, FRAMEPOINT_CENTER, 0.4, 0.22)\r\n        endif\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 3\r\n            if LoadInteger( udg_hash, id, StringHash( \"frg\" + I2S(cyclA) ) ) == 0 then\r\n                call SaveInteger( udg_hash, id, StringHash( \"frg\" + I2S(cyclA) ), itd[j+cyclA] )\r\n            else\r\n                set itd[j+cyclA] = LoadInteger( udg_hash, id, StringHash( \"frg\" + I2S(cyclA) ) )\r\n            endif\r\n            set forgetarget[cyclA] = CreateItem( itd[j+cyclA], GetUnitX(caster), GetUnitY(caster) )\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        call SaveBoolean( udg_hash, id, StringHash( \"frgdest\" ), dest )\r\n        /*\r\n        if LoadInteger( udg_hash, id, StringHash( \"frg2\" ) ) == 0 then\r\n            set itd[j+2] = it2\r\n            call SaveInteger( udg_hash, id, StringHash( \"frg2\" ), itd[j+2] )\r\n        else\r\n            set itd[j+2] = LoadInteger( udg_hash, id, StringHash( \"frg2\" ) )\r\n        endif\r\n\r\n        if LoadInteger( udg_hash, id, StringHash( \"frg3\" ) ) == 0 then\r\n            set itd[j+3] = it3\r\n            call SaveInteger( udg_hash, id, StringHash( \"frg3\" ), itd[j+3] )\r\n        else\r\n            set itd[j+3] = LoadInteger( udg_hash, id, StringHash( \"frg3\" ) )\r\n        endif\r\n        set forgetarget[2] = CreateItem( itd[j+2], GetUnitX(caster), GetUnitY(caster) )\r\n        set forgetarget[3] = CreateItem( itd[j+3], GetUnitX(caster), GetUnitY(caster) )\r\n        */\r\n        set udg_forgelose[i+1] = it\r\n\r\n        if p == GetLocalPlayer() then\r\n            call BlzFrameSetText(forgebut, \"Hide\")\r\n            call BlzFrameSetVisible(forgebuts, false)\r\n            call BlzFrameSetVisible(forgebut, true)\r\n        endif\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 3\r\n            if forgetarget[cyclA] != null then\r\n                set udg_forgeitem[j+cyclA] = GetItemTypeId(forgetarget[cyclA])\r\n                set text = BlzGetItemDescription(forgetarget[cyclA])\r\n                set k = 0.0003*StringLength(text)\r\n                if p == GetLocalPlayer() then\r\n                    call BlzFrameSetVisible(bgfrgfon[cyclA], true)\r\n                    call BlzFrameSetTexture( forgeicon[cyclA], BlzGetItemIconPath(forgetarget[cyclA]), 0, true )\r\n                    call BlzFrameSetText( forgename[cyclA], GetItemName(forgetarget[cyclA]) )\r\n\r\n                    call BlzFrameSetText( forgetool[cyclA], text )\r\n                \r\n                    call BlzFrameSetSize( forgetool[cyclA], 0.23, 0.02+k )\r\n                    call BlzFrameSetSize( forgename[cyclA], 0.21, 0.09+k )\r\n                    call BlzFrameSetSize(bgfrgfon[cyclA], 0.26, 0.08+k)\r\n\r\n                    call BlzFrameSetVisible(bgfrgfon[cyclA], true)\r\n                    \r\n                    call BlzFrameSetVisible(bgfrgfons[cyclA], false)\r\n                    call BlzFrameSetVisible(forgealticons[cyclA], false)\r\n                endif\r\n            endif\r\n            call RemoveItem( forgetarget[cyclA] )\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endif\r\n    \r\n    set cyclA = 1\r\n    loop\r\n        exitwhen cyclA > 3\r\n        set forgetarget[cyclA] = null\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n\tset p = null\r\n    set caster = null\r\n    set it = null\r\nendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}