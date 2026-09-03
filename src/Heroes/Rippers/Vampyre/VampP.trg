{
  "Id": 50333041,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope VampP initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ABILITY_ID = 'A0FC'\r\n\t\t\r\n\t\tprivate constant real LIFESTEAL_INITIAL = 0.05\r\n\t\tprivate constant real LIFESTEAL_PER_LEVEL = 0.05\r\n\t\tprivate constant integer DAMAGE_INITIAL = 10\r\n\t\tprivate constant integer DAMAGE_PER_LEVEL = 5\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetUnitAbilityLevel( udg_DamageEventSource, ABILITY_ID) > 0\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit target = udg_DamageEventTarget\r\n\t    local unit caster = udg_DamageEventSource\r\n\t    local integer level = GetUnitAbilityLevel( caster, ABILITY_ID)\r\n\t    local real lifesteal\r\n\t    local integer damage \r\n\t    \r\n\t    if IsMinion(target) then\r\n\t    \tset damage = DAMAGE_INITIAL + DAMAGE_PER_LEVEL * level\r\n\t    \tset udg_DamageEventAmount = udg_DamageEventAmount + damage\r\n\t    elseif IsUnitType( target, UNIT_TYPE_ANCIENT) then\r\n\t    \tset lifesteal = LIFESTEAL_INITIAL + LIFESTEAL_PER_LEVEL * level\r\n\t    \tcall healst(caster, null, udg_DamageEventAmount * lifesteal )\r\n\t    endif\r\n\t    \r\n\t    set target = null\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    call CreateEventTrigger( \"Event_OnDamageChange_Real\", function action, function condition )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}