{
  "Id": 50333219,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BardQ initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY = 'A1AL'\r\n        \r\n        private constant integer EFFECT = 'A1AM'\r\n        private constant integer BUFF = 'B06T'\r\n        private constant integer DURATION = 20\r\n    \r\n        private constant integer ID_MAGIC_RESISTANCE = 'A1C6'\r\n        private constant real MAGIC_RESISTANCE_BONUS = 0.15\r\n        \r\n        private constant integer ID_DODGE = 'A1CA'\r\n        private constant integer DODGE_BONUS = 20\r\n        \r\n        private constant integer BONUSES_CHANCE = 35\r\n        private constant integer BONUSES_COUNT = 12\r\n        private constant integer BONUSES_COUNT_ARRAY = BONUSES_COUNT+1\r\n        private integer array Bonuses[BONUSES_COUNT_ARRAY]\r\n        \r\n        private constant integer BONUSES_LIMIT = 6\r\n        private constant integer BONUSES_LIMIT_ALTERNATIVE = 12\r\n        \r\n        private constant integer BONUSES_STRING_COUNT = 1\r\n        private constant integer BONUSES_STRING_COUNT_ARRAY = BONUSES_STRING_COUNT+1\r\n        private string array Bonuses_String[BONUSES_STRING_COUNT_ARRAY]\r\n    endglobals\r\n    \r\n    private function SetBonuses takes nothing returns nothing\r\n        set Bonuses[1] = 'A1AN'\r\n        set Bonuses[2] = 'A1AO'\r\n        set Bonuses[3] = 'A1AP'\r\n        set Bonuses[4] = 'A1AQ'\r\n        set Bonuses[5] = 'A1AR'\r\n        set Bonuses[6] = 'A1AS'\r\n        set Bonuses[7] = 'A1C2'\r\n        set Bonuses[8] = 'A1C3'\r\n        set Bonuses[9] = 'A1C4'\r\n        set Bonuses[10] = 'A1C5'\r\n        set Bonuses[11] = 'A1C6'\r\n        set Bonuses[12] = 'A1CA'\r\n        \r\n        set Bonuses_String[0] = \" bonus!\"\r\n        set Bonuses_String[1] = \" bonuses!\"\r\n    endfunction\r\n\r\n    function Trig_BardQ_Conditions takes nothing returns boolean\r\n        return GetSpellAbilityId( ) == ID_ABILITY\r\n    endfunction\r\n\r\n    function BardQEnd takes nothing returns nothing\r\n        local integer id = GetHandleId( GetExpiredTimer( ) )\r\n        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"brdq\" ) )\r\n        local integer cyclA\r\n        \r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > BONUSES_COUNT\r\n            call UnitRemoveAbility( caster, Bonuses[cyclA] )\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        call UnitRemoveAbility( caster, EFFECT )\r\n        call UnitRemoveAbility( caster, BUFF )\r\n        call FlushChildHashtable( udg_hash, id )\r\n        \r\n        set caster = null\r\n    endfunction\r\n    \r\n    private function Alternative takes unit caster, unit target, real duration, integer level returns nothing \r\n        local integer i\r\n        local integer bonuses = 0\r\n        local integer newChance = R2I(BONUSES_CHANCE*(BONUSES_LIMIT/BONUSES_LIMIT_ALTERNATIVE))\r\n        local unit oldTarget = LoadUnitHandle( udg_hash, GetHandleId(caster), StringHash( \"brdq\" ) )\r\n    \r\n        if oldTarget != null then\r\n            set i = 1\r\n            loop\r\n                exitwhen i > BONUSES_COUNT\r\n                call UnitRemoveAbility( oldTarget, Bonuses[i] )\r\n                set i = i + 1\r\n            endloop\r\n            call UnitRemoveAbility( oldTarget, EFFECT )\r\n            call UnitRemoveAbility( oldTarget, BUFF )\r\n            call RemoveSavedHandle( udg_hash, GetHandleId( caster ), StringHash( \"brdq\" ) )\r\n        endif\r\n    \r\n        set i = 1\r\n        loop\r\n            exitwhen i > BONUSES_COUNT or bonuses >= BONUSES_LIMIT_ALTERNATIVE\r\n            if LuckChance(caster, newChance) or bonuses < level then\r\n                call UnitAddAbility( target, Bonuses[i] )\r\n                set bonuses = bonuses + 1\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n        \r\n        if bonuses > 0 then\r\n            call textst( \"|cFFFE8A0E +\" + I2S(bonuses) + Bonuses_String[IMinBJ(bonuses-1, BONUSES_STRING_COUNT)], caster, 64, 90, 10, 1 )\r\n            \r\n            call UnitAddAbility( target, EFFECT )\r\n            call InvokeTimerWithUnit(target, \"brdq\",  duration, false, function BardQEnd)\r\n            call SaveUnitHandle( udg_hash, GetHandleId(caster), StringHash( \"brdq\" ), target )\r\n            \r\n            call effst( caster, target, null, 1, duration )\r\n        endif\r\n        \r\n        set oldTarget = null\r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n    \r\n    private function Main takes unit caster, unit target, real duration, integer level returns nothing \r\n        local integer i\r\n        local integer bonuses = 0\r\n    \r\n        set i = 1\r\n        loop\r\n            exitwhen i > BONUSES_COUNT or bonuses >= BONUSES_LIMIT\r\n            if LuckChance(caster, BONUSES_CHANCE) or bonuses < level then\r\n                call UnitAddAbility( target, Bonuses[i] )\r\n                set bonuses = bonuses + 1\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n        \r\n        if bonuses > 0 then\r\n            call textst( \"|cFFFE8A0E +\" + I2S(bonuses) + Bonuses_String[IMinBJ(bonuses-1, BONUSES_STRING_COUNT)], caster, 64, 90, 10, 1 )\r\n            \r\n            call UnitAddAbility( target, EFFECT )\r\n            call InvokeTimerWithUnit(target, \"brdq\",  duration, false, function BardQEnd)\r\n            \r\n            call effst( caster, target, null, 1, duration )\r\n        endif\r\n        \r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n\r\n    function Trig_BardQ_Actions takes nothing returns nothing\r\n        local unit caster\r\n        local unit target\r\n        local integer lvl\r\n        local real t\r\n        \r\n        if CastLogic() then\r\n            set caster = udg_Caster\r\n            set target = udg_Target\r\n            set lvl = udg_Level\r\n            set t = udg_Time\r\n        elseif RandomLogic() then\r\n            set caster = udg_Caster\r\n            set target = randomtarget( caster, 900, \"ally\", \"\", \"\", \"\", \"\" )\r\n            set lvl = udg_Level\r\n            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )\r\n            set t = DURATION\r\n            if target == null then\r\n                set caster = null\r\n                return\r\n            endif\r\n        else\r\n            set caster = GetSpellAbilityUnit()\r\n            set target = GetSpellTargetUnit()\r\n            set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n            set t = DURATION\r\n        endif\r\n        set t = timebonus(caster, t)\r\n        \r\n        if Aspects_IsHeroAspectActive( caster, ASPECT_01 ) then\r\n            call Alternative( caster, target, t, lvl )\r\n        else\r\n            call Main( caster, target, t, lvl )\r\n        endif\r\n        \r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n    \r\n    private function DeleteBuff_Conditions takes nothing returns boolean\r\n        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0\r\n    endfunction\r\n    \r\n    private function DeleteBuff takes nothing returns nothing\r\n        local unit hero = Event_DeleteBuff_Unit\r\n        local integer i\r\n\r\n        set i = 1\r\n        loop\r\n            exitwhen i > BONUSES_COUNT\r\n            call UnitRemoveAbility( hero, Bonuses[i] )\r\n            set i = i + 1\r\n        endloop\r\n        call UnitRemoveAbility( hero, EFFECT )\r\n        call UnitRemoveAbility( hero, BUFF )\r\n        \r\n        set hero = null\r\n    endfunction\r\n    \r\n    //Magic Resistance\r\n    private function OnDamageChange_Conditions takes nothing returns boolean\r\n        return GetUnitAbilityLevel( udg_DamageEventTarget, ID_MAGIC_RESISTANCE) > 0 and udg_IsDamageSpell\r\n    endfunction\r\n    \r\n    private function OnDamageChange takes nothing returns nothing\r\n        local unit hero = udg_DamageEventTarget\r\n        \r\n        set udg_DamageEventAmount = udg_DamageEventAmount - (Event_OnDamageChange_StaticDamage*MAGIC_RESISTANCE_BONUS)\r\n        \r\n        set hero = null\r\n    endfunction\r\n    \r\n    //Dodge\r\n    private function OnDamageChange_Dodge_Conditions takes nothing returns boolean\r\n        return GetUnitAbilityLevel( udg_DamageEventTarget, ID_DODGE) > 0 and udg_IsDamageSpell == false\r\n    endfunction\r\n    \r\n    private function OnDamageChange_Dodge takes nothing returns nothing\r\n        if LuckChance( udg_DamageEventTarget, DODGE_BONUS ) then\r\n            set udg_DamageEventAmount = 0\r\n            set udg_DamageEventType = udg_DamageTypeBlocked\r\n        endif\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call SetBonuses()\r\n    \r\n        set gg_trg_BardQ = CreateTrigger( )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_BardQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n        call TriggerAddCondition( gg_trg_BardQ, Condition( function Trig_BardQ_Conditions ) )\r\n        call TriggerAddAction( gg_trg_BardQ, function Trig_BardQ_Actions )\r\n        \r\n        call CreateEventTrigger( \"Event_DeleteBuff_Real\", function DeleteBuff, function DeleteBuff_Conditions )\r\n        call CreateEventTrigger( \"Event_OnDamageChange_Real\", function OnDamageChange, function OnDamageChange_Conditions )\r\n        call CreateEventTrigger( \"Event_OnDamageChange_Real\", function OnDamageChange_Dodge, function OnDamageChange_Dodge_Conditions )\r\n    endfunction\r\n    \r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}