{
  "Id": 50333619,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Heuz1 initializer init\r\n\r\n\tglobals\r\n\t    private unit heuz = null\r\n\t    \r\n\t    public trigger Trigger1 = null\r\n\t    public trigger Trigger2 = null\r\n\t    \r\n\t    private constant integer DAMAGE = 50\r\n\t    private constant integer AREA_SIZE = 900\r\n\t    private constant string HIT_ANIMATION = \"Acid Ex.mdx\"\r\n\tendglobals\r\n\t\r\n\tprivate function OnDeath_Condition takes nothing returns boolean\r\n\t    return heuz != null and IsUnitAlive( heuz ) and IsDummy(GetDyingUnit()) == false\r\n\tendfunction\r\n\t\r\n\tprivate function OnDeath takes nothing returns nothing\r\n\t    call GroupAoE( heuz, GetUnitX(heuz), GetUnitY(heuz), DAMAGE, AREA_SIZE, \"enemy\", null, HIT_ANIMATION )\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetUnitTypeId(udg_DamageEventTarget) == 'e008'\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    set heuz = udg_DamageEventTarget\r\n\t    call DisableTrigger( GetTriggeringTrigger() )\r\n\tendfunction\r\n\t\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set Trigger1 = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function OnDeath, function OnDeath_Condition )\r\n\t    call DisableTrigger( Trigger1 )\r\n\t    \r\n\t    set Trigger2 = CreateEventTrigger( \"udg_AfterDamageEvent\", function action, function condition )\r\n\t    call DisableTrigger( Trigger2 )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}