library StartingBonus requires StartingBonusDatabase

	public function SpawnBonuses takes player playerUsed returns nothing
		local integer index = GetPlayerId(playerUsed) + 1
		local ListInt exceptions
		local integer i
		local integer bonusType
		local location bonusSpawn
		local integer globalPosition
		
		if GetPlayerSlotState(playerUsed) != PLAYER_SLOT_STATE_PLAYING then
			return
		endif
		
		set exceptions = ListInt.create()
		
		set i = 0
		loop
			exitwhen i > 2
			set globalPosition = ( 3 * index ) - i
			//call BJDebugMsg("globalPosition: " + I2S(globalPosition))
			set bonusSpawn = udg_itemcentr[globalPosition]
			if i == 0 then
				set bonusType = StartingBonusDatabase_GetRandomExtremeStartingBonus(exceptions)
			else
				set bonusType = StartingBonusDatabase_GetRandomSafeStartingBonus(exceptions)
			endif
			call exceptions.Add(bonusType)
			set ItemRandomizerLib_Reward[globalPosition] = CreateItemLoc( bonusType, bonusSpawn)
			call DestroyEffect( AddSpecialEffectLoc( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", bonusSpawn ) )
			set i = i + 1
		endloop
		
		set bonusSpawn = null
		call exceptions.destroy()
	endfunction

endlibrary