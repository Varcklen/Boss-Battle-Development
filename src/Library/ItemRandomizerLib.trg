{
  "Id": 50332077,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ItemRandomizerLib requires SetRaritySpawnLib\r\n\r\n    globals \r\n        boolean IsItemsRefreshed = false\r\n\r\n        real Event_ItemRewardCreate_Real\r\n        unit Event_ItemRewardCreate_Hero\r\n        integer Event_ItemRewardCreate_Position\r\n        integer Event_ItemRewardCreate_ItemReward\r\n    endglobals\r\n\r\n    function LegLogic takes integer i returns boolean\r\n        local integer cyclA = 1\r\n        local boolean l = false\r\n        \r\n    //if not( udg_Dublicate) then\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if inv( udg_hero[cyclA], DB_Items[3][i] ) > 0 then\r\n                set l = true\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    //endif\r\n        return l\r\n    endfunction\r\n\r\n    function RareLogic takes integer i returns boolean\r\n        local integer cyclA = 1\r\n        local boolean l = false\r\n    //if not( udg_Dublicate) then\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if inv( udg_hero[cyclA], DB_Items[2][i] ) > 0 then\r\n                set l = true\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    //endif\r\n        return l\r\n    endfunction\r\n\r\n    function CommonLogic takes integer i returns boolean\r\n        local integer cyclA = 1\r\n        local boolean l = false\r\n\r\n        //if not( udg_Dublicate) then\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if inv( udg_hero[cyclA], DB_Items[1][i] ) > 0 then\r\n                set l = true\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        //endif\r\n        return l\r\n    endfunction\r\n\r\n    function ItemCreate_ItemPosition takes integer c, integer index returns boolean\r\n        if index > 3 then\r\n            set index = 3\r\n        elseif index < 1 then\r\n            set index = 1\r\n        endif\r\n        return c == index or c == (3+index) or c == (6+index) or c == (9+index)\r\n    endfunction\r\n\r\n    function ItemCreate takes integer index, integer i, integer c returns nothing\r\n        local real x = GetLocationX(udg_itemcentr[c])\r\n        local real y = GetLocationY(udg_itemcentr[c])\r\n        local integer currentIndex = 0\r\n        \r\n        set Event_ItemRewardCreate_Hero = udg_hero[i]\r\n        set Event_ItemRewardCreate_Position = c\r\n        set Event_ItemRewardCreate_ItemReward = 0\r\n        \r\n        set Event_ItemRewardCreate_Real = 0.00\r\n        set Event_ItemRewardCreate_Real = 1.00\r\n        set Event_ItemRewardCreate_Real = 0.00\r\n        \r\n        set currentIndex = Event_ItemRewardCreate_ItemReward\r\n        \r\n        if inv(udg_hero[i], 'I01I') > 0 and ItemCreate_ItemPosition(c, 2) then\r\n            set currentIndex = udg_DB_Item_Destroyed[GetRandomInt(1,udg_DB_SetItems_Num[29])]\r\n        elseif inv(udg_hero[i], 'I0FT') > 0 and ItemCreate_ItemPosition(c, 3) then\r\n            set currentIndex = DB_SetItems[7][GetRandomInt(1,udg_DB_SetItems_Num[7])]\r\n        elseif udg_FutureBall[i] != 0 then\r\n            set currentIndex = udg_FutureBall[i]\r\n            set udg_FutureBall[i] = 0\r\n            call ChangeToolItem( udg_hero[i], 'I0FH', \"Future: \", \")|r\", \"Nothing\" )\r\n        \r\n        elseif currentIndex == 0 then\r\n            set currentIndex = index\r\n        endif\r\n        \r\n        if udg_modbad[25] and ItemCreate_ItemPosition(c, 1) and GetRandomInt(1, 3) == 1 then\r\n            set udg_item[c] = CreateItem('I0FC', x, y)\r\n            call SaveInteger( udg_hash, GetHandleId(udg_item[c]), StringHash( \"modbad25\" ), currentIndex )\r\n        else\r\n            set udg_item[c] = CreateItem( currentIndex, x, y)\r\n        endif\r\n        \r\n        if GetItemType(udg_item[c]) == ITEM_TYPE_ARTIFACT then\r\n            call SpecialEffectAngle( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectCaster.mdl\", 270, x, y )\r\n        else\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", x, y ) )\r\n        endif\r\n        \r\n        if GetItemTypeId(udg_item[c]) == 'I0FC' then\r\n            set udg_LastReward[c] = LoadInteger( udg_hash, GetHandleId(udg_item[c]), StringHash( \"modbad25\" ) )\r\n        else\r\n            set udg_LastReward[c] = GetItemTypeId(udg_item[c])\r\n        endif\r\n    endfunction\r\n\r\n    function ItemSpawn takes boolean a, boolean b, boolean c, boolean d returns nothing\r\n        local integer array i\r\n        local boolean array k\r\n        local integer cyclA\r\n        local integer cyclB\r\n        local integer cyclBEnd\r\n        local integer cyclC\r\n        local boolean l\r\n        local integer j\r\n        local integer m\r\n        local boolean h\r\n        local integer f\r\n\r\n        set k[0] = a\r\n        set k[1] = b\r\n        set k[2] = c\r\n        set k[3] = d\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if k[cyclA-1] then\r\n                set udg_ItemGetChoosed[cyclA] = false\r\n                set udg_ItemGetActive[cyclA] = true\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        set i[1] = GetRandomInt(1, udg_Database_NumberItems[udg_itemrarity[1]])\r\n        set cyclA = 2\r\n        loop\r\n            exitwhen cyclA > 12\r\n            set f = udg_itemrarity[cyclA]\r\n            set i[cyclA] = GetRandomInt(1, udg_Database_NumberItems[f])\r\n            if not(udg_Dublicate) and GetPlayerSlotState(Player((cyclA - 1)/3)) == PLAYER_SLOT_STATE_PLAYING then\r\n                set cyclB = 1\r\n                set cyclBEnd = cyclA - 1\r\n                loop\r\n                    exitwhen cyclB > cyclBEnd\r\n                    if i[cyclA] == i[cyclB] and f == udg_itemrarity[cyclB] and f != 0 then\r\n                        set cyclA = cyclA - 1\r\n                        set cyclB = cyclBEnd\r\n                    endif\r\n                    set cyclB = cyclB + 1\r\n                endloop\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 12\r\n            set j = (cyclA - 1)/3\r\n            set f = udg_itemrarity[cyclA]\r\n            set m = 0\r\n            if GetPlayerSlotState(Player( j )) == PLAYER_SLOT_STATE_PLAYING and k[j] then\r\n                set cyclB = 1\r\n                loop\r\n                    exitwhen cyclB > 1\r\n                    set cyclC = 1\r\n                    set l = false\r\n                    loop\r\n                        exitwhen cyclC > 12\r\n                        if GetItemTypeId(udg_item[cyclC]) == DB_Items[f][i[cyclA]] then\r\n                            set l = true\r\n                            set cyclC = 12\r\n                        endif\r\n                        set cyclC = cyclC + 1\r\n                    endloop\r\n                    set cyclC = 1\r\n                    loop\r\n                        exitwhen cyclC > 4\r\n                        if inv( udg_hero[cyclC], DB_Items[f][i[cyclA]] ) > 0 then\r\n                            set l = true\r\n                            set cyclC = 4\r\n                        endif\r\n                        set cyclC = cyclC + 1\r\n                    endloop\r\n                    if l and not(udg_Dublicate) and m < 10 then\r\n                        if i[cyclA] != 1 then\r\n                            set i[cyclA] = i[cyclA] - 1\r\n                            set m = m + 1\r\n                        else\r\n                            set i[cyclA] = udg_Database_NumberItems[f]\r\n                        endif\r\n                        set cyclB = cyclB - 1\r\n                    else\r\n                        call ItemCreate(DB_Items[f][i[cyclA]], j+1, cyclA )\r\n                    endif\r\n                    set cyclB = cyclB + 1\r\n                endloop\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endfunction\r\n\r\n    function ItemRandomizerAll takes unit caster, integer it returns item\r\n        local integer randl = GetRandomInt(1, 100)\r\n        local integer cyclA = 1\r\n        local integer rand\r\n\r\n        set udg_ItemBuf = null\r\n        if randl <= udg_RarityChance[3] then\r\n            loop\r\n                exitwhen cyclA > 1\r\n                set rand = GetRandomInt(1, udg_Database_NumberItems[3])\r\n                if LegLogic(rand) then\r\n                    set cyclA  = cyclA - 1\r\n                else\r\n                    set udg_ItemBuf = CreateItem(DB_Items[3][rand], GetUnitX(caster), GetUnitY(caster) )\r\n                endif\r\n                set cyclA = cyclA  + 1\r\n            endloop\r\n        elseif randl >= udg_RarityChance[3]+1 and randl <= udg_RarityChance[2] then\r\n            loop\r\n                exitwhen cyclA > 1\r\n                set rand = GetRandomInt(1, udg_Database_NumberItems[2])\r\n                if RareLogic(rand) then\r\n                    set cyclA  = cyclA - 1\r\n                else\r\n                    set udg_ItemBuf = CreateItem(DB_Items[2][rand], GetUnitX(caster), GetUnitY(caster) )\r\n                endif\r\n                set cyclA = cyclA + 1\r\n            endloop\r\n        elseif randl >= udg_RarityChance[2]+1 then\r\n            loop\r\n                exitwhen cyclA > 1\r\n                set rand = GetRandomInt(1, udg_Database_NumberItems[1])\r\n                if CommonLogic(rand) then\r\n                    set cyclA  = cyclA - 1\r\n                else\r\n                    set udg_ItemBuf = CreateItem(DB_Items[1][rand], GetUnitX(caster), GetUnitY(caster) )\r\n                endif\r\n                set cyclA = cyclA  + 1\r\n            endloop\r\n        endif\r\n        if it == GetItemTypeId(udg_ItemBuf) then\r\n            call SetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + 200 )\r\n        endif\r\n        if udg_ItemBuf != null then\r\n            call UnitAddItem( caster, udg_ItemBuf )\r\n            set bj_lastCreatedItem = udg_ItemBuf\r\n        endif\r\n        set caster = null\r\n        return udg_ItemBuf\r\n    endfunction\r\n\r\n    function ItemRandomizer takes unit caster, string str returns item\r\n        local integer rand = GetRandomInt(1, 100)\r\n        local integer cyclA = 1\r\n        local integer i\r\n        local integer it\r\n        local integer r\r\n        local integer k = 0\r\n        \r\n        set bj_lastCreatedItem = null\r\n        if UnitInventoryCount(caster) < 6 then \r\n            if str == \"legendary\" then\r\n                set i = 3\r\n            elseif str == \"rare\" then\r\n                set i = 2\r\n            elseif str == \"common\" then\r\n                set i = 1\r\n            endif\r\n            \r\n            loop\r\n                exitwhen cyclA > 1\r\n                set r = GetRandomInt(1, udg_Database_NumberItems[i])\r\n                if k < 12 and (( LegLogic(r) and str == \"legendary\" ) or ( RareLogic(r) and str == \"rare\" ) or ( CommonLogic(r) and str == \"common\" )) then\r\n                    set cyclA  = cyclA - 1\r\n                    set k = k + 1\r\n                else\r\n                    if str == \"legendary\" then\r\n                        set it = DB_Items[3][r]\r\n                    elseif str == \"rare\" then\r\n                        set it = DB_Items[2][r]\r\n                    elseif str == \"common\" then\r\n                        set it = DB_Items[1][r]\r\n                    endif\r\n                    //bj_lastCreatedItem обязателен\r\n                    set bj_lastCreatedItem = CreateItem( it, GetUnitX(caster), GetUnitY(caster) )\r\n                    call UnitAddItem( caster, bj_lastCreatedItem )\r\n                endif\r\n                set cyclA = cyclA  + 1\r\n            endloop\r\n        endif\r\n        set caster = null\r\n        return bj_lastCreatedItem\r\n    endfunction\r\n    \r\n    //Return set item\r\n    function ItemRandomizerSet takes unit caster, integer it, integer settag, integer salvage returns item\r\n        local integer rand = GetRandomInt(1, udg_DB_SetItems_Num[settag])\r\n        set udg_ItemBuf = null\r\n        set udg_ItemBuf = CreateItem(DB_SetItems[settag][rand], GetUnitX(caster), GetUnitY(caster) )\r\n        if it == GetItemTypeId(udg_ItemBuf) then\r\n            call SetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(caster), PLAYER_STATE_RESOURCE_GOLD) + salvage )\r\n        endif\r\n        if udg_ItemBuf != null then\r\n            call UnitAddItem( caster, udg_ItemBuf )\r\n            set bj_lastCreatedItem = udg_ItemBuf\r\n        endif\r\n        set caster = null\r\n        return udg_ItemBuf\r\n    endfunction\r\n\r\n    function ItemRandomizerItemId takes unit caster, string str returns integer\r\n        local integer rand = GetRandomInt(1, 100)\r\n        local integer cyclA = 1\r\n        local integer i\r\n        local integer it = 0\r\n        local integer r\r\n        local integer k = 0\r\n        \r\n        if str == \"legendary\" then\r\n            set i = 3\r\n        elseif str == \"rare\" then\r\n            set i = 2\r\n        elseif str == \"common\" then\r\n            set i = 1\r\n        endif\r\n        \r\n        loop\r\n            exitwhen cyclA > 1\r\n            set r = GetRandomInt(1, udg_Database_NumberItems[i])\r\n            if k < 12 and (( LegLogic(r) and str == \"legendary\" ) or ( RareLogic(r) and str == \"rare\" ) or ( CommonLogic(r) and str == \"common\" )) then\r\n                set cyclA  = cyclA - 1\r\n                set k = k + 1\r\n            else\r\n                if str == \"legendary\" then\r\n                    set it = DB_Items[3][r]\r\n                elseif str == \"rare\" then\r\n                    set it = DB_Items[2][r]\r\n                elseif str == \"common\" then\r\n                    set it = DB_Items[1][r]\r\n                endif\r\n            endif\r\n            set cyclA = cyclA  + 1\r\n        endloop\r\n        \r\n        set caster = null\r\n        return it\r\n    endfunction\r\n\r\n    function Randomizer takes boolean a, boolean b, boolean c, boolean d returns nothing\r\n        local integer cyclA = 1\r\n        local integer cyclB\r\n        local integer rand\r\n        local integer j \r\n        local boolean l = false\r\n\r\n        if a and b and c and d then\r\n            set l = true\r\n        endif\r\n        \r\n        if l and udg_logic[98] and not(udg_logic[76]) then\r\n            call SetRaritySpawn( udg_RarityChance[3]+20, udg_RarityChance[2]+20 )\r\n        endif\r\n\r\n        if not( udg_worldmod[1] ) and not( udg_worldmod[8] ) then\r\n            set cyclA = 1\r\n            loop\r\n                exitwhen cyclA > 12 \r\n                set j = ( ( cyclA - 1 ) / 3 ) + 1\r\n                set udg_itemrarity[cyclA] = 0\r\n                if GetPlayerSlotState(Player( j - 1 )) == PLAYER_SLOT_STATE_PLAYING and not( inv( udg_hero[j], 'I0AC' ) > 0 and not(udg_logic[GetPlayerId( GetOwningPlayer( udg_hero[j] ) ) + 1 + 26]) and ( cyclA == 2 or cyclA == 5 or cyclA == 8 or cyclA == 11 ) ) then\r\n                    set rand = GetRandomInt(1, 100)\r\n                    if rand <= udg_RarityChance[3] or ( udg_logic[76] and l ) then\r\n                        set udg_itemrarity[cyclA] = 3\r\n                    elseif ( rand > udg_RarityChance[3] and rand <= udg_RarityChance[2] ) or ( inv( udg_hero[j], 'I0BU' ) > 0 and (cyclA == 3 or cyclA == 6 or cyclA == 9 or cyclA == 12) ) then\r\n                        set udg_itemrarity[cyclA] = 2\r\n                    elseif rand > udg_RarityChance[2] then\r\n                        set udg_itemrarity[cyclA] = 1\r\n                    endif\r\n                endif\r\n                set cyclA = cyclA + 1\r\n            endloop\r\n            call ItemSpawn( a,b,c,d)\r\n        endif\r\n        \r\n        if l and udg_logic[98] and not(udg_logic[76]) then\r\n            set udg_logic[98] = false\r\n            call SetRaritySpawn( udg_RarityChance[3]-20, udg_RarityChance[2]-20 )\r\n            call IconFrameDel( \"Rarity\" )\r\n        endif\r\n        \r\n        if udg_logic[76] and l then\r\n            set udg_logic[76] = false\r\n            call IconFrameDel( \"LegBook\" )\r\n        endif\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}