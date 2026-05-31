library BossSpawn

	public function Create takes player owner, integer unitType, real x, real y, real angle, integer key1, integer key2 returns unit
		local unit newBoss = CreateUnit( owner, unitType, x, y, angle )
		local integer id = GetHandleId(newBoss)
		
		call SaveInteger(udg_hash, id, StringHash("boss_level"), key1 )
		call SaveInteger(udg_hash, id, StringHash("boss_index"), key2 )
		call SetUnitUserData( newBoss, 5)
		
		return newBoss
	endfunction
	
	public function GetBossKeyLevel takes unit boss returns integer
		return LoadInteger(udg_hash, GetHandleId(boss), StringHash("boss_level"))
	endfunction
	
	public function GetBossKeyIndex takes unit boss returns integer
		return LoadInteger(udg_hash, GetHandleId(boss), StringHash("boss_index"))
	endfunction
	
endlibrary