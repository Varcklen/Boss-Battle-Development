{
  "Id": 50332966,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AdventurerW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A12L'\r\nendfunction\r\n\r\nfunction AdventurerWCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit u = LoadUnitHandle( udg_hash, id, StringHash( \"advw\" ) )\r\n    call UnitRemoveAbility( u, LoadInteger( udg_hash, id, StringHash( \"advw\" ) ) )\r\n    call UnitRemoveAbility( u, LoadInteger( udg_hash, id, StringHash( \"advwb\" ) ) )\r\n    call FlushChildHashtable( udg_hash, id )\r\n    call RemoveSavedReal( udg_hash, GetHandleId( u ), StringHash( \"advrd\" ) )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\nfunction Trig_AdventurerW_Actions takes nothing returns nothing\r\n    local integer id \r\n    local unit caster\r\n    local unit target\r\n    local integer rand = GetRandomInt( 1, 3 )\r\n    local integer lvl\r\n    local real t\r\n    local integer sp\r\n    local integer spp\r\n    local integer bf\r\n    local integer i\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", \"hero\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        set t = 25\r\n        call textst( udg_string[0] + GetObjectName('A12L'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n        set t = 25\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    set id = GetHandleId( target )\r\n    set i = GetPlayerId( GetOwningPlayer( target ) ) + 1\r\n    \r\n    if rand == 1 then\r\n        if combat( caster, false, 0 ) and not( udg_fightmod[3] ) then\r\n            call statst( target, 1, 0, 0, 192, true )\r\n            call textst( \"|c00FF2020 +1 strength\", target, 64, 90, 10, 1 )\r\n        endif\r\n        set sp = 'A12N'\r\n        set spp = 'A12M'\r\n        set bf = 'B05T'\r\n    elseif rand == 2 then\r\n        if combat( caster, false, 0 ) and not( udg_fightmod[3] ) then\r\n            call statst( target, 0, 1, 0, 196, true )\r\n            call textst( \"|c0020FF20 +1 agility\", target, 64, 90, 10, 1 )\r\n        endif\r\n        call SaveReal( udg_hash, GetHandleId( target ), StringHash( \"advwd\" ), 1 - (0.05 * lvl) )\r\n        set sp = 'A12P'\r\n        set spp = 'A12O'\r\n        set bf = 'B05U'\r\n    elseif rand == 3 then\r\n        if combat( caster, false, 0 ) and not( udg_fightmod[3] ) then\r\n            call statst( target, 0, 0, 1, 200, true )\r\n            call textst( \"|c002020FF +1 intelligence\", target, 64, 90, 10, 1 )\r\n        endif\r\n        set sp = 'A12R'\r\n        set spp = 'A12Q'\r\n        set bf = 'B05V'\r\n    endif\r\n    \r\n    call UnitAddAbility( target, sp )\r\n    call SetUnitAbilityLevel( target, spp, lvl )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"advw\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"advw\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"advw\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"advw\" ), target )\r\n    call SaveInteger( udg_hash, id, StringHash( \"advw\" ), sp )\r\n    call SaveInteger( udg_hash, id, StringHash( \"advwb\" ), bf )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( \"advw\" ) ), t, false, function AdventurerWCast )\r\n    \r\n    call effst( caster, target, null, lvl, t )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AdventurerW takes nothing returns nothing\r\n    set gg_trg_AdventurerW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_AdventurerW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_AdventurerW, Condition( function Trig_AdventurerW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AdventurerW, function Trig_AdventurerW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}