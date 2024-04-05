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

	public function Register takes nothing returns nothing
		call InitUnmergedOrb(TAG_UNMERGED_ORB)
	endfunction

endlibrary