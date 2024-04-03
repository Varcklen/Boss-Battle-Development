library LocationSystem

	public function PolarProjection takes location loc1, location loc2, real distance returns location
        local real angle = AngleBetweenPoints( loc1, loc2)
        return PolarProjectionBJ( loc1, distance, angle)
    endfunction
    
    public function GetMovedEffect takes effect wave, real angle, real distance returns location
    	local real yaw = angle * bj_DEGTORAD
        local real x = BlzGetLocalSpecialEffectX( wave ) + distance * Cos( yaw )
        local real y = BlzGetLocalSpecialEffectY( wave ) + distance * Sin( yaw )
        return Location(x, y)
    endfunction
    
    public function GetMovedBetweenUnits takes unit unitWho, unit unitTo, real distance returns location
    	local real unitWhoX = GetUnitX( unitWho )
    	local real unitWhoY = GetUnitY( unitWho )
    	local real unitToX = GetUnitX( unitTo )
    	local real unitToY = GetUnitY( unitTo )
        local real angle = Atan2( unitToY - unitWhoY, unitToX - unitWhoX )
        local real x = unitWhoX + distance * Cos( angle )
        local real y = unitWhoY + distance * Sin( angle )
        return Location(x, y)
    endfunction

endlibrary