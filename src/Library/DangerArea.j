library DangerArea requires CommonTimer, IndicatorSystem

	globals
		private effect temp_Effect = null
		
		private constant string ANIMATION = "war3mapImported\\AuraOfDeath.mdx"
		private constant string STRING_HASH_STRING = "particle_delete"
		private constant integer STRING_HASH = StringHash(STRING_HASH_STRING)
		
		private constant integer REVERSE_AREA_SIZE = 150
		
		private effect array ReverseEffects[100][500]
		private integer ReverseEffects_Max = 0
		private integer UseIndex = 0
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
	
	public function CreateReverse takes real xArea, real yArea, real areaSize, real duration returns integer
		local rect rectUsed = udg_Boss_Rect
		local real x 
		local real y
		local real xMax = GetRectMaxX(rectUsed)
		local real yMin = GetRectMinY(rectUsed)
		local location point
		local location areaLoc = Location( xArea, yArea )
		
		set UseIndex = UseIndex + 1
		if UseIndex > 90 then
			set UseIndex = 0
		endif
		
		set ReverseEffects_Max = 0
		set x = GetRectMinX(rectUsed)
		loop
			exitwhen x > xMax
			//call BJDebugMsg("x")
			set y = GetRectMaxY(rectUsed)
			loop
				exitwhen y < yMin
				/*call BJDebugMsg("y")
				call BJDebugMsg("------------------")
				call BJDebugMsg("x: "+ R2S(x))
				call BJDebugMsg("y: "+ R2S(y))*/
				set point = Location( x, y )
				if DistanceBetweenPoints(point, areaLoc ) > areaSize then
					set ReverseEffects[UseIndex][ReverseEffects_Max] = IndicatorSystem_Create(INDICATOR_SKULL, x, y, REVERSE_AREA_SIZE, duration, null)
					set ReverseEffects_Max = ReverseEffects_Max + 1
				endif 
				call RemoveLocation(point)
				set y = y - REVERSE_AREA_SIZE
			endloop
			set x = x + REVERSE_AREA_SIZE
		endloop
		/*call BJDebugMsg("=================")
		call BJDebugMsg("xMax: "+ R2S(xMax))
		call BJDebugMsg("yMin: "+ R2S(yMin))
		call BJDebugMsg("=================")*/

		call RemoveLocation(areaLoc)
		set areaLoc = null
		set point = null
		set rectUsed = null
		return UseIndex
	endfunction
	
	public function RemoveReverse takes integer useIndex returns nothing
		local integer i

		set i = 0
		loop
			exitwhen i >= ReverseEffects_Max
			call IndicatorSystem_Remove(ReverseEffects[UseIndex][i])
			set i = i + 1
		endloop
	endfunction

endlibrary