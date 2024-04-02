library ThrowingKnifeLib requires JesterLib, ManastLib

	globals
		private constant integer KNIFES_TO_THROW = 2
		private constant integer DAMAGE = 5
		private constant integer MANA_RESTORE = 10
		
		private constant integer TARGET_SEARCH_RANGE = 600
		private constant integer SPEED = 1250
		private constant real TICK = 0.04
		private constant real TICK_SPEED = SPEED * TICK
	endglobals
	
	private function motion takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "trknt" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "trknc" ) )
	    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "trkn" ) )
	    local real x = GetUnitX( target )
	    local real y = GetUnitY( target )
	    local real xd = GetUnitX( dummy )
	    local real yd = GetUnitY( dummy )
	    local real angle = Atan2( y - yd, x - xd )
	    local real NewX = xd + TICK_SPEED * Cos( angle )
	    local real NewY = yd + TICK_SPEED * Sin( angle )
	    local real IfX = ( x - xd ) * ( x - xd )
	    local real IfY = ( y - yd ) * ( y - yd )
	    
	    if SquareRoot( IfX + IfY ) > 100 and IsUnitAlive( target) then
	        call SetUnitPosition( dummy, NewX, NewY )
	    else
	        call hpoisonst( caster, target, 1 )
	        call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	        call RemoveUnit( dummy )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	
	    set dummy = null
	    set target = null
	    set caster = null
	endfunction
	
	public function Cast takes unit caster returns nothing
		local unit target
	    local unit dummy
	    local integer id
	    local integer i
	    
	    set i = 1
	    loop
	        exitwhen i > KNIFES_TO_THROW
	        set target = randomtarget( caster, TARGET_SEARCH_RANGE, "enemy", "", "", "", "" )
	        if target != null then
	            set dummy = CreateUnit( GetOwningPlayer( caster ), 'u000', GetUnitX( caster ), GetUnitY( caster ), AngleBetweenUnits( caster, target ) )
	            call UnitAddAbility( dummy, 'A0IF' ) 
	            
	            set id = InvokeTimerWithUnit( dummy, "trkn", TICK, true, function motion )
	            call SaveUnitHandle( udg_hash, id, StringHash( "trknc" ), caster )
	            call SaveUnitHandle( udg_hash, id, StringHash( "trknt" ), target )
	        endif
	        set i = i + 1
	    endloop
	    call manast( caster, null, MANA_RESTORE )
	    
	    set target = null
	    set dummy = null
	endfunction

endlibrary