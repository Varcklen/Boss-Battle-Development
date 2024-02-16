{
  "Id": 50332124,
  "Comment": "",
  "IsScript": false,
  "RunOnMapInit": false,
  "Script": "",
  "Events": [
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 3,
            "VariableId": 100663339,
            "arrayIndexValues": [
              {
                "ParamType": 5,
                "value": "0"
              },
              {
                "ParamType": 5,
                "value": "0"
              }
            ],
            "value": null
          }
        ],
        "value": "TriggerRegisterTimerExpireEventBJ"
      }
    }
  ],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": [
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 5,
            "value": "Change Notes"
          }
        ],
        "value": "CommentString"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Change Notes 1.5.2"
          },
          {
            "ParamType": 5,
            "value": "|c00ffcc001.5.2:|r (Varcklen & Sadtwig)\r\n- Runestone Mos rework. No longer interacts with summon builds.\r\n- Houndmaster W no longer allows summoning additional Crisps.\r\n- Reduced enemy spawn timer in Infinite Arena from 15s to 12s.\r\n- Runesmith Rocks increased hitpoints to 200 from 10.\r\n- Runesmith Rocks dying while being carved causes the Rune to be carved early.\r\n- Runesmith Q cooldown reduced to 4s from 5s.\r\n- Runesmith E is now disabled during duels.\r\n- Updated Jagot tooltip to more clearly state that cooldowns only get reduced if the ability has more than 4 seconds of cooldown remaining.\r\n- Fixed Dreamcatcher for Runesmith. Fizzling on purpose for Shepherd."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNScrollOfHealing.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 5,
            "value": "----"
          }
        ],
        "value": "CommentString"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Information"
          },
          {
            "ParamType": 5,
            "value": "|cffffcc00Author:|r Varcklen\r\n|cffffcc00Assistant:|r ZiHeLL  \r\n|cffffcc00PayPal:|r \r\nwww.paypal.me/bbwc3\r\n|cffffcc00Patreon:|r \r\nwww.patreon.com/bbwc3\r\n|c00ffcc00Discord:|r discordapp.com/invite/KVfrcby\r\n|c00ffcc00Discord.me:|r discord.me/bbwc3\r\nThe icons are taken from the game World of Warcraft."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "About the map"
          },
          {
            "ParamType": 5,
            "value": "|c00ffcc00-time X|r Sets the timer out of combat. This command is only available to the host. X - timer time in seconds (no more than 300; no less than 60; the timer is off, if 0).\r\n|c00ffcc00-zoom X|r/|c00ffcc00-cam X|r Changes the camera range (where X is a number from 1 to 5).\r\n|c00ffcc00-item X Y|r Allows changing items in inventory. X is the position of the first item in the inventory. Y is the position of the second item in the inventory.\r\n|c00ffcc00-kick X|r Allows voting to exclude a player from the game. Voting continues until everyone confirms their consent to the exclusion or 30 seconds pass. X - player number (red - 1, blue - 2, etc.)\r\n|c00ffcc00-tp|r Teleports the hero to the preparatory room. It works only outside the battlefield.\r\n|c00ffcc00-debug|r Corrects errors on the map. Teleports all heroes to the preparatory room.\r\n|c00ffcc00-load X-XXXXX-XX|r Load your save file.\r\n|c00ffcc00-autoload|r Automatically downloads your current save file.\r\n|c00ffcc00-endgame|r After winning, you can continue playing. You will start killing bosses again, but you will retain all your experience from previous battles. Enemies will have +200% health, attack power and spell damage, as well as -20% ability cooldown for each end victory of the game.\r\n|c00ffcc00-endnow|r Ends the current arena from Cute Bob. The command is only available to the host.\r\n|c00ffcc00-color X|r Changes the color of the player. Works only outside of combat. X is a number from 1 to 24."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNStrongDrink.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Acknowledgments"
          },
          {
            "ParamType": 5,
            "value": "Thank you for your help in developing the map:\r\n- Sheepy\r\n- Rena\r\n- Mike\r\n- Leviolon\r\n- Banderling\r\n- Glen\r\n- Ratman\r\n- Infoneral\r\n- Eric\r\n- Wondershovel\r\n- ZiHeLL\r\n- Aza_zelko\r\n- xWizard\r\n- Zolo\r\n- Wtii\r\n- 2kxaoc\r\n- vatk0end\r\n- hooka\r\n- Pohx\r\n- mrhans\r\n- Leviolon\r\n- faceroll\r\n- Yoti Coyote\r\n- Lichloved\r\n- Poor Kimmo\r\n- stonebludgeon\r\n- SkifterOk"
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNMurgalSlave.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 5,
            "value": "Old Change Notes"
          }
        ],
        "value": "CommentString"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Change Notes 1.5.1"
          },
          {
            "ParamType": 5,
            "value": "|c00ffcc001.5.1x:|r (Sadtwig)\r\n- Runesmith W body has more attack range\r\n- Runesmith collecting a Rune of the Strongman fixed.\r\n- Runesmith Q and W reset at end of battle and are now combat only.\r\n- Carvable Rocks no longer spawn in pvp.\r\n\r\n|c00ffcc001.5.1:|r (Sadtwig)\r\n- New Hero: Runesmith\r\n- Devourer E now correctly applies bonus magic damage.\r\n- Mixology now doesn't work out of combat with Witcher Medallion\r\n- Faceless Spy can no longer turn into itself.\r\n- Shepherd E now counts towards Trembling Enemies quest.\r\n- Fixed \"On a new One\" not granting a hero if random pick attempts were exhausted."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeReqDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Change Notes 1.5.0"
          },
          {
            "ParamType": 5,
            "value": "|c00ffcc001.5.0z:|r (Sadtwig)\r\n- Removed Debug Message from Shepherd R & made sheep scale in size.\r\n- Fixed Reign of the Legend Quest.\r\n|c00ffcc001.5.0y:|r (Sadtwig)\r\n- Fixed Overlord Arena to trigger BossDeath effects like Quest: Fullfillment of Will & Soul Swap.\r\n- Changed Shepherd R to spawn sheeps with increased stats.\r\n- Fixed typo in Barbarian Q Tooltip on level 4.\r\n|c00ffcc001.5.0x:|r (Sadtwig)\r\n- Fixed Shepherd Q breaking with invulnerable units.\r\n|c00ffcc001.5.0:|r \r\n(Sadtwig)\r\n- Added a new hero: Shepherd\r\n- Fixed on-summon effect item interactions.\r\n- Buffed Orb of Twilight Flame.\r\n- Rebalanced Orb of Nerzhul\r\n- Fixed Minotaur not losing stats from his passive w"
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNScroll.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 5,
            "value": "----"
          }
        ],
        "value": "CommentString"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeOptDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Commands"
          },
          {
            "ParamType": 5,
            "value": "|c00ffcc00-time X|r Sets the timer out of combat. This command is only available to the host. X - timer time in seconds (no more than 300; no less than 60; the timer is off, if 0).\r\n|c00ffcc00-zoom X|r/|c00ffcc00-cam X|r Changes the camera range (where X is a number from 1 to 5).\r\n|c00ffcc00-item X Y|r Allows changing items in inventory. X is the position of the first item in the inventory. Y is the position of the second item in the inventory.\r\n|c00ffcc00-kick X|r Allows voting to exclude a player from the game. Voting continues until everyone confirms their consent to the exclusion or 30 seconds pass. X - player number (red - 1, blue - 2, etc.)\r\n|c00ffcc00-tp|r Teleports the hero to the preparatory room. It works only outside the battlefield.\r\n|c00ffcc00-debug|r Corrects errors on the map. Teleports all heroes to the preparatory room.\r\n|c00ffcc00-load X-XXXXX-XX|r Load your save file.\r\n|c00ffcc00-autoload|r Automatically downloads your current save file.\r\n|c00ffcc00-endgame|r After winning, you can continue playing. You will start killing bosses again, but you will retain all your experience from previous battles. Enemies will have +200% health, attack power and spell damage, as well as -20% ability cooldown for each end victory of the game.\r\n|c00ffcc00-endnow|r Ends the current arena from Cute Bob. The command is only available to the host.\r\n|c00ffcc00-color X|r Changes the color of the player. Works only outside of combat. X is a number from 1 to 24.\r\n|c00ffcc00-notnew|r Turns off \"beginner mode\" and gives access to all stores."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNHeartOfAszune.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeOptDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Distortion"
          },
          {
            "ParamType": 5,
            "value": "Host can change the parameters on the map before starting the first battle.\r\nX - number in %, by which the parameter will change.\r\nY - The player whose parameter will change.\r\n(1 - red, 2 - blue, 3 - teal, 4 - purple)\r\n\r\n|c00ffcc00-stat|r Shows the parameters of the current distortion.\r\n|c00ffcc00-set hp X|r Changes the health of enemies.\r\n|c00ffcc00-set at X|r Changes the attack power of enemies.\r\n|c00ffcc00-set sp X|r Changes the spell power of enemies.\r\n|c00ffcc00-set heal Y X|r Changes the effectiveness of health and mana heals.\r\n|c00ffcc00-set heal all X|r Changes the effectiveness of health and mana heals for all players.\r\n|c00ffcc00-set dmg ph Y X|r Changes physical damage.\r\n|c00ffcc00-set dmg ph all X|r Changes the physical damage for all players.\r\n|c00ffcc00-set dmg mg Y X|r Changes magic damage.\r\n|c00ffcc00-set dmg mg all X|r Changes magic damage for all players."
          },
          {
            "ParamType": 5,
            "value": "ReplaceableTextures\\CommandButtons\\BTNCrystalBall.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    },
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 2,
            "value": "QuestTypeOptDiscovered"
          },
          {
            "ParamType": 5,
            "value": "Progress system"
          },
          {
            "ParamType": 5,
            "value": "- There is a progress system on the map.\r\n- Every time you win or lose, you get experience, which is spent on gaining new levels.\r\n- Each new level gives you new opportunities: bonus items, skins, new items in the rotation, and more.\r\n- The full list of bonuses can be viewed on our server in Discord.\r\n- At levels 1-5, you will get access to new shops.\r\n- From level 5, you will unlock hero skins.\r\n- Up to level 20, you will receive bonuses, and then only skins."
          },
          {
            "ParamType": 5,
            "value": "war3mapImported\\PASBTNAchievement_BG_returnXflags_def_WSG.blp"
          }
        ],
        "value": "CreateQuestBJ"
      }
    }
  ]
}