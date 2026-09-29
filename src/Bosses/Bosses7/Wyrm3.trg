{
  "Id": 50333572,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Wyrm3 initializer init\r\n\t\r\n\tglobals\r\n\t\tprivate constant real DAMAGE_PERCENTAGE = 0.085\r\n\tendglobals\r\n\t\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetUnitTypeId(BeforeAttack.TriggerUnit) == 'e00G' and GetUnitTypeId(BeforeAttack.TargetUnit) == 'o00M'\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal real newValue = GetUnitState( BeforeAttack.TargetUnit, UNIT_STATE_MAX_LIFE) * DAMAGE_PERCENTAGE\r\n\t\t//call BJDebugMsg(\"cast\")\r\n\t\tcall BeforeAttack.SetDataReal(\"damage\", newValue)\r\n\t    if IsUnitAlive( BeforeAttack.TriggerUnit ) then\r\n\t        call KillUnit( BeforeAttack.TriggerUnit )\r\n\t    endif\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_Wyrm3 = BeforeAttack.AddListener(function action, function condition)\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}