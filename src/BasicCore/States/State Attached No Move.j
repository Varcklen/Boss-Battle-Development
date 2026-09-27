scope AttachedNoMove initializer init

	globals
		private constant integer ORDER_CHECK_1 = 851971//smart
		private constant integer ORDER_CHECK_2 = 851983//attack
		private constant integer ABILITY_CHECK = 'A1K3'
		
	endglobals

	private function condition takes nothing returns boolean
		/*call BJDebugMsg("action id: " + I2S(GetIssuedOrderId()) )
		call BJDebugMsg("action: " + OrderId2String(GetIssuedOrderId()) )
		call BJDebugMsg("ORDER_CHECK_1: " + I2S(ORDER_CHECK_1) )
		call BJDebugMsg("ORDER_CHECK_1: " + OrderId2String(ORDER_CHECK_1) )
		call BJDebugMsg("ORDER_CHECK_2: " + I2S(ORDER_CHECK_2) )
		call BJDebugMsg("ORDER_CHECK_2: " + OrderId2String(ORDER_CHECK_2) )*/
		if GetUnitAbilityLevel(GetOrderedUnit(), ABILITY_CHECK) == 0 then
			//call BJDebugMsg("GetUnitAbilityLevel(GetOrderedUnit(), ABILITY_CHECK) == 0")
			return false
		endif
		if GetIssuedOrderId() == ORDER_CHECK_1 then
			return true
		endif
		if GetIssuedOrderId() == ORDER_CHECK_2 then
			return true
		endif
		return false
	endfunction
	
	private function StopAction takes nothing returns nothing
    	local integer id = GetHandleId( GetExpiredTimer() )
    	local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "attachment_stop" ) )
    	
    	//call BJDebugMsg("unit: " + GetUnitName(caster) )
    	call IssueImmediateOrderBJ( caster, "stop" )
	
		set caster = null
	endfunction
	
	private function action takes nothing returns nothing
		//call BJDebugMsg("action stop")
		//call BJDebugMsg("unit before: " + GetUnitName(GetOrderedUnit()) )
		call InvokeTimerWithUnit( GetOrderedUnit(), "attachment_stop", 0.01, false, function StopAction )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER, function action, function condition )
	endfunction

endscope