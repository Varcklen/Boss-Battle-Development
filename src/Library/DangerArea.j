library DangerArea requires CommonTimer

	globals
		private effect temp_Effect = null
		
		private string ANIMATION = "war3mapImported\\AuraOfDeath.mdx"
		private string STRING_HASH_STRING = "particle_delete"
		private integer STRING_HASH = StringHash(STRING_HASH_STRING)
	endglobals

	private function end takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local effect particle = LoadEffectHandle(udg_hash, id, STRING_HASH )
		
		call DestroyEffect( particle )
		call FlushChildHashtable( udg_hash, id )
		
		set particle = null
	endfunction

	public function Create takes real x, real y, real area, real duration returns effect
		set temp_Effect = AddSpecialEffect( ANIMATION, x, y )
		call BlzSetSpecialEffectScale( temp_Effect, area / 100 )
		
		call InvokeTimerWithEffect( temp_Effect, STRING_HASH_STRING, duration, false, function end )
		
		return temp_Effect
	endfunction

endlibrary