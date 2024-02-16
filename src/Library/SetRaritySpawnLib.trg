{
  "Id": 50332078,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library SetRaritySpawnLib\r\n\r\n    function SetRaritySpawn takes integer leg, integer rar returns nothing\r\n        set udg_RarityChance[3] = leg\r\n        set udg_RarityChance[2] = rar\r\n        set udg_RarityChance[1] = IMaxBJ(0,100-(udg_RarityChance[3]+udg_RarityChance[2]))\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}