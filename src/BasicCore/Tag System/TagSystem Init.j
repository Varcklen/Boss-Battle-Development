library TagSystemInit requires TagSystem

	private function InitUnmergedOrb takes integer tagType returns nothing
		local integer i = 1
		local integer iMax = udg_Database_NumberItems[8]
		local integer stringHash = TagSystem_GetTagData(tagType).StringHash

		loop
			exitwhen i > iMax
			call SaveBoolean(TagSystem_TagTable, udg_DB_Orb[i], stringHash, true)
			set i = i + 1
		endloop
	endfunction
	
	private function InitCorrupted takes integer tagType returns nothing
		local integer i = 1
		local integer iMax = udg_Database_NumberItems[29]
		local integer stringHash = TagSystem_GetTagData(tagType).StringHash

		loop
			exitwhen i > iMax
			call SaveBoolean(TagSystem_TagTable, udg_DB_Item_Destroyed[i], stringHash, true)
			set i = i + 1
		endloop
	endfunction
	
	private function InitActivatable takes integer tagType returns nothing
		local integer i = 1
		local integer iMax = udg_Database_NumberItems[31]
		local integer stringHash = TagSystem_GetTagData(tagType).StringHash

		loop
			exitwhen i > iMax
			call SaveBoolean(TagSystem_TagTable, udg_DB_Item_Activate[i], stringHash, true)
			set i = i + 1
		endloop
	endfunction
	
	private function InitPotion takes integer tagType returns nothing
		local integer i = 1
		local integer iMax = udg_Database_NumberItems[9]
		local integer stringHash = TagSystem_GetTagData(tagType).StringHash
		
		set i = 1
		loop
			exitwhen i > iMax
			call SaveBoolean(TagSystem_TagTable, udg_Database_Item_Potion[i], stringHash, true)
			set i = i + 1
		endloop
		
		set i = 1
		set iMax = 8
		loop
			exitwhen i > iMax
			//call BJDebugMsg("=====================: ")
			//call BJDebugMsg("itemType: " + I2S(Alchemists_Stone_Potions[i]))
			if Alchemists_Stone_Potions[i] != 0 then
				//set bj_lastCreatedItem = CreateItem(Alchemists_Stone_Potions[i], 0, 0)
				//call BJDebugMsg("item: " + GetItemName(bj_lastCreatedItem))
				call SaveBoolean(TagSystem_TagTable, Alchemists_Stone_Potions[i], stringHash, true)
			endif
			set i = i + 1
		endloop
	endfunction

	public function InitTripleSet takes integer piece1, integer piece2, integer piece3 returns nothing
		local integer stringHash = TagSystem_GetTagData(TAG_TRIPLE_SET_PIECE).StringHash
		
		call SaveBoolean(TagSystem_TagTable, piece1, stringHash, true)
		call SaveBoolean(TagSystem_TagTable, piece2, stringHash, true)
		call SaveBoolean(TagSystem_TagTable, piece3, stringHash, true)
	endfunction

	public function Register takes nothing returns nothing
		call InitUnmergedOrb(TAG_UNMERGED_ORB)
		call InitCorrupted(TAG_CORRUPTED)
		call InitActivatable(TAG_ACTIVATABLE)
		call InitPotion(TAG_POTION)
	endfunction

endlibrary