library StartingBonus requires StartingBonusDatabase

	public function SpawnBonuses takes player playerUsed returns nothing
		local integer index = GetPlayerId(playerUsed) + 1
		local ListInt exceptions = ListInt.create()
		local integer i
		local integer bonusType
		local location bonusSpawn
		local integer globalPosition
		
		set i = 0
		loop
			exitwhen i > 2
			set globalPosition = ( 3 * index ) - i
			set bonusSpawn = udg_itemcentr[globalPosition]
			set bonusType = StartingBonusDatabase_GetRandomStartingBonus(exceptions)
			call exceptions.Add(bonusType)
			set ItemRandomizerLib_Reward[globalPosition] = CreateItemLoc( bonusType, bonusSpawn)
			call DestroyEffect( AddSpecialEffectLoc( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", bonusSpawn ) )
			set i = i + 1
		endloop
		
		set bonusSpawn = null
		call exceptions.destroy()
	endfunction

endlibrary