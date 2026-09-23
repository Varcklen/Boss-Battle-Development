library Lightning requires DeathLib

    globals
        private lightning TempLightning = null
    endglobals
    
    function MoveLightningUnits takes lightning l, unit u, unit n returns nothing
        call MoveLightningEx(l, true, GetUnitX(u), GetUnitY(u), GetUnitFlyHeight(u), GetUnitX(n), GetUnitY(n), GetUnitFlyHeight(n))
    endfunction

	//===========================================================================
    private function End takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        call DestroyLightning( LoadLightningHandle( udg_hash, id, StringHash( "light" ) ) )
        call FlushChildHashtable( udg_hash, id )
    endfunction

    public function CreateLightning takes string lightningType, real xStart, real yStart, real zStart, real xEnd, real yEnd, real zEnd, real lifeTime returns lightning
        local timer timerUsed
    
        set TempLightning = AddLightningEx(lightningType, true, xStart, yStart, zStart, xEnd, yEnd, zEnd )
        
        if lifeTime != 0 then
        	set timerUsed = CreateTimer()
	        call SaveTimerHandle( udg_hash, GetHandleId( TempLightning ), StringHash( "light" ), timerUsed )
	        call SaveLightningHandle( udg_hash, GetHandleId( timerUsed ), StringHash( "light" ), TempLightning )
	        call TimerStart( timerUsed, lifeTime, false, function End )
        endif
        
        set timerUsed = null
        return TempLightning
    endfunction
    
    public function CreateToUnits takes string lightningType, unit unitStart, unit unitEnd, real lifeTime returns lightning
        return CreateLightning( lightningType, GetUnitX(unitStart), GetUnitY(unitStart), GetUnitFlyHeight(unitStart), GetUnitX(unitEnd), GetUnitY(unitEnd), GetUnitFlyHeight(unitEnd), lifeTime )
    endfunction

	//===========================================================================
	private function CheckCondition takes unit unitStart, unit unitEnd, lightning ray, boolean destroyIfUnitDies returns boolean
		if ray == null or GetLightningColorA(ray) == 0 then
			return true
		endif
		
		if destroyIfUnitDies == false then
			return false
		endif
		
		if IsUnitDead(unitStart) then
			return true
		endif
		if IsUnitDead(unitEnd) then
			return true
		endif
		return false
	endfunction
	
	private function UpdateRay takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit unitStart = LoadUnitHandle( udg_hash, id, StringHash( "ray_start_unit" ) )
	    local unit unitEnd = LoadUnitHandle( udg_hash, id, StringHash( "ray_end_unit" ) )
	    local lightning ray = LoadLightningHandle( udg_hash, id, StringHash( "ray_used" ) )
	    local boolean destroyIfUnitDies = LoadBoolean( udg_hash, id, StringHash("ray_is_destroy") )
	    local real startZ
	    local real endZ
	    
	    /*if ray == null or GetLightningColorA(ray) == 0 then
	    	call BJDebugMsg("ray is null")
	    endif
	    call BJDebugMsg("GetLightningColorA: " + R2S(GetLightningColorA(ray)) )
	    call BJDebugMsg("unitStart: " + GetUnitName(unitStart) )
	    call BJDebugMsg("unitEnd: " + GetUnitName(unitEnd) )*/
	    if CheckCondition(unitStart, unitEnd, ray, destroyIfUnitDies ) then
	    	//call BJDebugMsg("end")
	    	call DestroyLightning( ray )
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set startZ = LoadReal(udg_hash, id, StringHash("ray_start_unit_z") )
	    	set endZ = LoadReal(udg_hash, id, StringHash("ray_end_unit_z") )
	    	call MoveLightningEx( ray, true, GetUnitX(unitStart), GetUnitY(unitStart), startZ, GetUnitX(unitEnd), GetUnitY(unitEnd), endZ )
	    endif
	    
	    set unitStart = null
	    set unitEnd = null
	    set ray = null
	endfunction
	
    public function CreateFollowingRayWithZ takes string lightningType, unit unitStart, real unitStartZ, unit unitEnd, real unitEndZ, boolean destroyIfUnitDies returns lightning
    	local timer usedTimer = CreateTimer()
    	local integer id = GetHandleId( usedTimer )
    
    	set TempLightning = AddLightningEx(lightningType, true, GetUnitX(unitStart), GetUnitY(unitStart), unitStartZ, GetUnitX(unitEnd), GetUnitY(unitEnd), unitEndZ )
  
		call SaveUnitHandle( udg_hash, id, StringHash("ray_start_unit"), unitStart )
		call SaveUnitHandle( udg_hash, id, StringHash("ray_end_unit"), unitEnd )
		call SaveLightningHandle( udg_hash, id, StringHash("ray_used"), TempLightning )
		call SaveBoolean( udg_hash, id, StringHash("ray_is_destroy"), destroyIfUnitDies )
		call SaveReal(udg_hash, id, StringHash("ray_start_unit_z"), unitStartZ )
		call SaveReal(udg_hash, id, StringHash("ray_end_unit_z"), unitEndZ )
        call TimerStart( usedTimer, 0.04, true, function UpdateRay )
        
        set usedTimer = null
        return TempLightning
    endfunction
    
    public function CreateFollowingRay takes string lightningType, unit unitStart, unit unitEnd, boolean destroyIfUnitDies returns lightning
        return CreateFollowingRayWithZ( lightningType, unitStart, GetUnitFlyHeight(unitStart), unitEnd, GetUnitFlyHeight(unitEnd), destroyIfUnitDies )
    endfunction

endlibrary