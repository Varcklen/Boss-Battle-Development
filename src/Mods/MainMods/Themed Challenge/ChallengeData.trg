{
  "Id": 50332208,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ChallengeData initializer init requires LibDataItems\r\n    globals\r\n        private constant integer DARK_PORTAL = 1\r\n        private constant integer SLOWNESS = 2\r\n        private constant integer GRAVE = 3\r\n        private constant integer FLAME = 4\r\n        private constant integer SUPPRESSION = 5\r\n        private constant integer SUCCUMBING = 6\r\n        private constant integer EQUALITY = 7\r\n        private constant integer FATIGUE = 8\r\n        private constant integer DEFICIT = 9\r\n        private constant integer THE_POWER_OF_MAGIC = 10\r\n        private constant integer ACCELERATION = 11\r\n        private constant integer REINCARNATION = 12\r\n        private constant integer SEAL_OF_WEAKNESS = 13\r\n        private constant integer SUPPORT = 14\r\n        private constant integer SCATTER = 15\r\n        private constant integer DETONATION = 16\r\n        private constant integer STORM = 17\r\n        private constant integer STEADFASTNESS = 18\r\n        private constant integer DARKNESS = 19\r\n        private constant integer TRASH = 20\r\n        private constant integer COUNTERSTRIKE = 21\r\n        private constant integer ZEAL = 22\r\n        private constant integer LAZINESS = 23\r\n        private constant integer SEEKER = 24\r\n        private constant integer MYSTERY = 25\r\n        private constant integer ANGER = 26\r\n        private constant integer WILD_GROWTH = 27\r\n        private constant integer ELECTRIC_STORM = 28\r\n        private constant integer MISTRUST = 29\r\n        private constant integer FIRST_BLOOD = 30\r\n        private constant integer CONFUSION = 31\r\n        private constant integer RIVALVY = 32\r\n        \r\n        private constant integer CHALLENGE_COUNT = 10\r\n        public constant integer CURSES = 5\r\n        private constant integer CURSES_ARRAYS = CURSES + 1\r\n        integer array Theme_Ability[CHALLENGE_COUNT]\r\n        integer array Challenges[CHALLENGE_COUNT][CURSES_ARRAYS]//Номер испытания/проклятия\r\n        \r\n        integer Chosen_Challenge = 0\r\n    endglobals\r\n    \r\n    private function SetMod takes integer number, integer themeId, integer curse1, integer curse2, integer curse3, integer curse4, integer curse5 returns nothing\r\n        set Theme_Ability[number] = themeId\r\n        set Challenges[number][1] = curse1\r\n        set Challenges[number][2] = curse2\r\n        set Challenges[number][3] = curse3\r\n        set Challenges[number][4] = curse4\r\n        set Challenges[number][5] = curse5\r\n    endfunction\r\n    \r\n    private function SetNewDescription takes nothing returns nothing\r\n        local string newDesc = BlzFrameGetText(modesDescription[3][1])\r\n        local integer i\r\n    \r\n        //BlzGetAbilityTooltip(udg_DB_ModesFrame_Ability[cyclA], 0), BlzGetAbilityExtendedTooltip(udg_DB_ModesFrame_Ability[cyclA], 0)\r\n        set newDesc = newDesc + \"|n|n\" + BlzGetAbilityTooltip(Theme_Ability[Chosen_Challenge], 0) + \"|n\" + BlzGetAbilityExtendedTooltip(Theme_Ability[Chosen_Challenge], 0) + \"|n\"\r\n        \r\n        set i = 1\r\n        loop\r\n            exitwhen i > CURSES\r\n            set newDesc = newDesc + \"|n -\" + BlzGetAbilityExtendedTooltip(udg_DB_BadMod[Challenges[Chosen_Challenge][i]], 0)\r\n            set i = i + 1\r\n        endloop\r\n    \r\n        call SetStableToolDescription( modesDescription[3][1], newDesc )\r\n    endfunction\r\n    \r\n    private function SetMods takes nothing returns nothing\r\n        set udg_base = 0\r\n        call SetMod(BaseNum(), 'A1D4', STORM, ELECTRIC_STORM, DETONATION, WILD_GROWTH, SEEKER )\r\n        call SetMod(BaseNum(), 'A1D5', ANGER, COUNTERSTRIKE, STEADFASTNESS, SUPPORT, ZEAL )\r\n        call SetMod(BaseNum(), 'A1D6', MYSTERY, GRAVE, TRASH, DEFICIT, ACCELERATION )\r\n        call SetMod(BaseNum(), 'A1D7', MISTRUST, RIVALVY, SCATTER, FLAME, DARKNESS )\r\n        call SetMod(BaseNum(), 'A1D8', FIRST_BLOOD, REINCARNATION, SUCCUMBING, EQUALITY, SUPPRESSION )\r\n        call SetMod(BaseNum(), 'A1D9', CONFUSION, FATIGUE, LAZINESS, SEAL_OF_WEAKNESS, MISTRUST )\r\n        \r\n        set Chosen_Challenge = GetRandomInt(1, udg_base)\r\n        \r\n        call SetNewDescription()\r\n    endfunction\r\n    \r\n    private function init takes nothing returns nothing\r\n        call TimerStart( CreateTimer(), 1, false, function SetMods )\r\n    endfunction\r\nendlibrary\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}