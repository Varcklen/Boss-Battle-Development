scope CheatCheckRarity initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing
		local integer i
		local real array chance
		
		call SetRaritySpawn( 7, 34 )
		
		set i = 1
		loop
			exitwhen i > 3
			set chance[i] = 1.0 * udg_RarityChance[i] / udg_Database_NumberItems[i] //( udg_RarityChance[i] / 100.0 ) * (1.0 / udg_Database_NumberItems[i] ) * 100.0
			set i = i + 1
		endloop
			
		call BJDebugMsg("Chance to get...")
		call BJDebugMsg("=============================")
		call BJDebugMsg("|cffffcc00Common items in pool:|r " + I2S(udg_Database_NumberItems[1]))
		call BJDebugMsg("|cffffcc00Rare items in pool:|r " + I2S(udg_Database_NumberItems[2]))
		call BJDebugMsg("|cffffcc00Legendary items in pool:|r " + I2S(udg_Database_NumberItems[3]))
		call BJDebugMsg("----------------------------")
		call BJDebugMsg("|cffffcc00Common item:|r " + I2S(udg_RarityChance[1]))
		call BJDebugMsg("|cffffcc00Rare item:|r " + I2S(udg_RarityChance[2]))
		call BJDebugMsg("|cffffcc00Legendary item:|r " + I2S(udg_RarityChance[3]))
		call BJDebugMsg("----------------------------")
		call BJDebugMsg("|cffffcc00Common item from their pool:|r  " + R2S(100.0 / udg_Database_NumberItems[1]) + "%")
		call BJDebugMsg("|cffffcc00Rare item from their pool:|r " + R2S(100.0 / udg_Database_NumberItems[2]) + "%")
		call BJDebugMsg("|cffffcc00Legendary item from their pool:|r " + R2S(100.0 / udg_Database_NumberItems[3]) + "%")
		call BJDebugMsg("----------------------------")
		call BJDebugMsg("|cffffcc00exact Common item:|r " + R2S(chance[1]) + "%")
		call BJDebugMsg("|cffffcc00exact Rare item:|r " + R2S(chance[2]) + "%")
		call BJDebugMsg("|cffffcc00exact Legendary item:|r " + R2S(chance[3]) + "%")
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-rarity", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope