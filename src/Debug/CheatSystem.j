library CheatSystem initializer init requires Multiboard

	globals
		private Cheat array Cheats
		private integer Cheats_Max = 0
		
		private boolean IsCheatEnabled = false
		private player Cheater = null
	endglobals
	
	private function SetCheats takes nothing returns nothing
		call Cheat.create(gg_trg_Cheatnext, "-next X", "Moves the game to X boss level. If X is not specified, moves to the next level.")
		call Cheat.create(gg_trg_Cheatmoney, "-money", "Gives each player 1000 gold.")
		call Cheat.create(gg_trg_Cheattp, "-tpgo", "Teleports and resurrects all heroes in their rooms.")
		call Cheat.create(gg_trg_Cheateasy, "-easy", "Adds 5 attempts.")
		call Cheat.create(gg_trg_Cheattpboss, "-tpboss", "Forces the fight to begin.")
		call Cheat.create(gg_trg_Cheatcast, "-cast", "Enables/disables the mode. In this mode, when you press the up arrow, it restores all mana and removes the cooldown of abilities from heroes.")
		call Cheat.create(gg_trg_Cheatheroes, "-heroes", "Displays the number of players and their names.")
		call Cheat.create(gg_trg_Cheatcombat, "-combat", "Enables/disables the combat mode.")
		call Cheat.create(gg_trg_Cheatboss, "-boss X", "Sets boss X as the next one from the current level.")
		call Cheat.create(gg_trg_Cheattest, "-test", "Enables -cast mode, gives 100k gold, +20 levels and enables combat mode.")
		call Cheat.create(gg_trg_Cheatmodgood, "-bless X", "Enables blessing X. See -modcheck for a list.")
		call Cheat.create(gg_trg_Cheatmodbad, "-curse X", "Enables curse X. See -modcheck for a list.")
		call Cheat.create(CheatCheckMods_Trigger, "-modcheck", "Displays a list of all active and inactive blessings and curses.")
		call Cheat.create(gg_trg_CheatSwap, "-swap", "Forces players to swap souls (heroes).")
		call Cheat.create(trig_CheatCreate, "-create", "Creates heroes for blue, teal and purple players.")
		call Cheat.create(gg_trg_Exchange, "-exchange", "Creates an item for the blue player in the exchanger and forces to confirm the exchange.")
		call Cheat.create(CheatHalf_Trigger, "-half", "Sets the hero's health and mana to 50%.")
		call Cheat.create(gg_trg_ManaReg, "-manareg", "Enables/disables tracking of the hero's mana.")
		call Cheat.create(gg_trg_Cast, "-casts X Y", "The player casts a random spell [X][Y].")
		call Cheat.create(gg_trg_Refresh, "-ref", "Refreshes special shop.")
		call Cheat.create(CheatLowHp_Trigger, "-lowhp", "Reduces the hero's health to minimum.")
		call Cheat.create(CheatLowMp_Trigger, "-lowmp", "Reduces the hero's mana to minimum.")
		call Cheat.create(CheatPvPStart, "-pvp", "Starts a PvP battle between red and blue players.")
		call Cheat.create(CheatKill, "-kill", "Kills all heroes.")
		call Cheat.create(trig_CheatBuff, "-buff", "Gives the hero a big amount of attack, health, movement speed and attack speed.")
		call Cheat.create(trig_CheatOutOfCombatTimer, "-fast", "Set the out-of-combat timer to 6 seconds.")
		call Cheat.create(trig_CheatSimulateLeaver, "-leaver", "Simulate a player leaving the game.")
		call Cheat.create(trig_CheatWhoDead, "-who", "Displays a list of living and dead heroes.")
		call Cheat.create(trig_CheatTakeMagicDamage, "-take", "The hero receives 100 magic damage.")
		call Cheat.create(CheatTakeBigMagicDamage_Trigger, "-takeb", "The hero receives 1000 magic damage.")
		call Cheat.create(trig_CheatRandomAbility, "-chaos", "The hero casts all random spells.")
		call Cheat.create(CheatBlessAll_Trigger, "-blessall", "Enables all blessings.")
		call Cheat.create(CheatCheckStats_Trigger, "-stats", "Displays a list with data about stats.")
		call Cheat.create(CheatBerserk_Trigger, "-rage", "The hero enters berserk mode for 10 seconds.")
		call Cheat.create(CheatSets_Trigger, "-sets", "Displays the number of entities from sets on the player.")
		call Cheat.create(CheatSmallPool_Trigger, "-pool", "Set small artifact pool." )
	endfunction

	public function IsCheatsEnabled takes nothing returns boolean
		return IsCheatEnabled
	endfunction
	
	public function GetCheater takes nothing returns player
		return Cheater
	endfunction

	struct Cheat
		readonly trigger Trigger
		readonly string Code
		readonly string Description
		
		static method create takes trigger triggerUsed, string codeUsed, string description returns thistype
			local thistype p = thistype.allocate()
			
			set p.Trigger = triggerUsed
			set p.Code = codeUsed
			set p.Description = description
			
			set Cheats[Cheats_Max] = p
			set Cheats_Max = Cheats_Max + 1
			
            return p
        endmethod
	endstruct
	
	private function CreateInfo takes nothing returns nothing
		local string text1 = ""
		local string text2 = ""
		local integer i = 0
		local integer iMax = Cheats_Max
		local integer limit = 13
		
		loop
			exitwhen i >= limit
			set text1 = text1 + "|cffffcc00" + Cheats[i].Code + "|r " + Cheats[i].Description + "|n"
			set i = i + 1
		endloop
		
		set i = limit
		loop
			exitwhen i >= iMax
			set text2 = text2 + "|cffffcc00" + Cheats[i].Code + "|r " + Cheats[i].Description + "|n"
			set i = i + 1
		endloop
	
		call CreateQuestBJ( bj_QUESTTYPE_REQ_DISCOVERED, "Cheats #1", text1, "ReplaceableTextures\\CommandButtons\\BTNPolymorph.blp" )
		call CreateQuestBJ( bj_QUESTTYPE_REQ_DISCOVERED, "Cheats #2" , text2, "ReplaceableTextures\\CommandButtons\\BTNPolymorph.blp" )
	endfunction
	
	public function Enable takes player cheater, boolean enableTriggers returns nothing
		local integer i 
		local integer iMax
	
		set udg_logic[0] = true
		set Cheater = cheater
        set IsCheatEnabled = true
        call MultiSetColor( udg_multi, 3, 2, 80.00, 0.00, 0.00, 25.00 )
        call CreateInfo()
        
        if enableTriggers == false then
        	return
    	endif
        
		set i = 0
		set iMax = Cheats_Max
		loop
			exitwhen i >= iMax
			call EnableTrigger( Cheats[i].Trigger )
			set i = i + 1
		endloop
	endfunction
	
	private function Disable takes nothing returns nothing
		local integer i = 0
		local integer iMax = Cheats_Max

		loop
			exitwhen i >= iMax
			call DisableTrigger( Cheats[i].Trigger )
			set i = i + 1
		endloop
	endfunction
	
	private function delay takes nothing returns nothing
		call SetCheats()
		
		if GetPlayerName(Player(0)) == "WorldEdit" then
	        call Enable(Player(0), false)
	    endif
		
		if IsCheatEnabled == false then
			call Disable()
		endif
	endfunction
	
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function delay )
	endfunction

endlibrary