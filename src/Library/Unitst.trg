{
  "Id": 50332058,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library UnitstLib\r\n\r\n    function unitst takes unit target, unit caster, string str returns boolean \r\n        if GetUnitState( target, UNIT_STATE_LIFE ) > 0.405 and GetUnitAbilityLevel( target, 'A1FY') == 0 and GetOwningPlayer( target ) != Player( PLAYER_NEUTRAL_PASSIVE ) then\r\n            if str == \"enemy\" and IsUnitEnemy( target, GetOwningPlayer( caster ) ) and GetUnitAbilityLevel( target, 'Avul') == 0 then\r\n                return true\r\n            elseif str == \"ally\" and IsUnitAlly( target, GetOwningPlayer( caster ) ) then\r\n                return true\r\n            elseif str == \"all\" and GetUnitAbilityLevel( target, 'Avul') == 0  then\r\n                return true\r\n            endif\r\n        endif\r\n        return false\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}